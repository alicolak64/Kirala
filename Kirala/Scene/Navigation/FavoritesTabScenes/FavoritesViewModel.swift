//
//  FavoritesViewModel.swift
//  Kirala
//
//  Created by Ali Çolak on 14.06.2024.
//

import Foundation

final class FavoritesViewModel {
    
    // MARK: - Dependency Properties
    
    weak var delegate: FavoritesViewProtocol?
    
    private let router: FavoritesRouterProtocol
    private let authService: AuthService
    private let favoriteService: FavoriteService
    
    private var favorites = [Product]()
    private var filteredFavorites = [Product]()
    private var isSearchActive: Bool = false
    private var isRequiredRefresh: Bool = false
    private var requiredDeleteIds = [String]()
    
    private var loadingState: LoadingState = .loading {
        didSet {
            switch loadingState {
            case .loading:
                delegate?.showLoading()
            case .loaded(let result):
                delegate?.hideLoading(loadResult: result)
            }
        }
    }
    
    private var emptyState: EmptyState?
    
    // MARK: - Initializers
    
    init(router: FavoritesRouterProtocol, dependencies: [Dependency: Any]) {
        guard let authService = dependencies[.authService] as? AuthService,
              let favoriteService = dependencies[.favoriteService] as? FavoriteService
        else {
            fatalError("AuthService not found")
        }
        self.router = router
        self.authService = authService
        self.favoriteService = favoriteService
    }
    
    deinit {
        removeObserver()
    }
    
    // MARK: - Private Functions
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(favoritesChanged(_:)), name: .changedFavorite, object: nil)
    }
    
    private func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: .changedFavorite, object: nil)
    }
    
    @objc private func favoritesChanged(_ notification: Notification) {
        
        
        guard let userInfo = notification.userInfo,
              let productId = userInfo[NotificationCenterOutputs.productId.rawValue] as? String,
              let isFavorite = userInfo[NotificationCenterOutputs.isFavorite.rawValue] as? Bool
        else {
            return
        }
        
        
        if isFavorite {
            isRequiredRefresh = true
        } else {
            requiredDeleteIds.append(productId)
        }
        
    }
    
    private func getItems() -> [Product] {
        isSearchActive ? filteredFavorites : favorites
    }
    
}

extension FavoritesViewModel: FavoritesViewModelProtocol {
    
    // MARK: - Lifecycle Methods
    
    func viewDidLoad() {
        
        delegate?.prepareNavigationBar()
        delegate?.prepareUI()
        delegate?.addRefreshControl()
        
        guard authService.isLoggedIn else {
            return
        }
        
        addObserver()
        fetchMyFavorites()
        
    }
    
    func viewWillAppear() {
        
        guard authService.isLoggedIn else {
            delegate?.showEmptyState(with: .noLoginFavorites)
            emptyState = .noLoginFavorites
            return
        }
        
        if emptyState == .noLoginFavorites {
            fetchMyFavorites()
            emptyState = nil
        }
        
        if emptyState == .noFavorites {
            delegate?.showEmptyState(with: .noFavorites)
            emptyState = .noFavorites
        }
        
        if isRequiredRefresh {
            fetchMyFavorites()
            isRequiredRefresh = false
            requiredDeleteIds.removeAll()
        }
        
        if !requiredDeleteIds.isEmpty {
            
            if isSearchActive {
                filteredFavorites.removeAll { requiredDeleteIds.contains($0.id) }
                delegate?.reloadTableView()
                if filteredFavorites.isEmpty {
                    delegate?.showEmptyState(with: .noFavorites)
                }
            } else {
                favorites.removeAll { requiredDeleteIds.contains($0.id) }
                delegate?.reloadTableView()
                if favorites.isEmpty {
                    delegate?.showEmptyState(with: .noFavorites)
                }
            }
            
            requiredDeleteIds.removeAll()
            
        }
        
        
        
    }
    
    func viewDidAppear() {
        
    }
    
    func viewDidDisappear() {
        
    }
    
    func viewDidLayoutSubviews() {
        delegate?.prepareConstraints()
    }
    
    // MARK: - Actions
    
    func didTapEmptyStateActionButton() {
        
        switch emptyState {
        case .error:
            fetchMyFavorites()
        case .noLoginFavorites:
            router.navigate(to: .auth)
        case .noFavorites:
            router.navigate(to: .home)
        default:
            break
        }
        
    }
    
    func numberOfItemsInSection() -> Int {
        1
    }
    
    func numberOfItems(in section: Int) -> Int {
        getItems().count
    }
    
    func cellForItem(at indexPath: IndexPath) -> FavoriteCellArguments? {
        
        guard let product = getItems()[safe: indexPath.row] else {
            return nil
        }
        
        return FavoriteCellArguments(id: product.id, brand: product.brand, name: product.name, imageUrl: product.imageUrl, price: product.price)
        
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        
        guard getItems().indices.contains(indexPath.row) else {
            return
        }
        
        let argument = DetailArguments(id: getItems()[indexPath.row].id)
        
        router.navigate(to: .detail(argument))
    }
    
    func sizeForItem(at indexPath: IndexPath, frame: CGSize) -> CGSize {
        CGSize(width: frame.width, height: 150)
    }
    
    func searchTextDidChange(_ searchText: String) {
        isSearchActive = !searchText.trimmed.isEmpty
        filteredFavorites = favorites.filter {
            $0.name.lowercased().contains(searchText.lowercased()) || $0.brand.lowercased().contains(searchText.lowercased())
        }
        delegate?.reloadTableView()
    }
    
    func didTapDeleteButton(with id: String) {
        
        guard
            let token = authService.getAuthToken(),
            let index = getItems().firstIndex(where: { $0.id == id })
        else {
            return
        }
        
        if isSearchActive {
            filteredFavorites.remove(at: index)
        } else {
            favorites.remove(at: index)
        }
        
        notifyFavoriteProductChanged(id: id, isFavorite: false)
        delegate?.deleteRows(at: [IndexPath(row: index, section: 0)])
        
        if getItems().isEmpty {
            emptyState = .noFavorites
            delegate?.showEmptyState(with: .noFavorites)
        }
        
        favoriteService.toggleFavorite(productId: id, token: token) { result in }
        
    }
    
    private func fetchMyFavorites() {
        
        guard let token = authService.getAuthToken() else { return }
        
        loadingState = .loading
        
        favoriteService.getFavorites(token: token) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    guard let products = response.data else { return }
                    self.loadingState = .loaded(.none)
                    self.favorites = products.map { Product(brand: $0.brand, name: $0.name, price: $0.price.toCurrencyString(), imageUrl: $0.imageUrl ?? String.noImageURLString, id: $0.id, favoriteState: FavoriteState(isFavorite: $0.isFavorite) ) }
                    self.delegate?.endRefreshing()
                    self.assignData()
                case .failure(let error):
                    self.loadingState = .loaded(.none)
                    self.emptyState = .error(error)
                    self.delegate?.endRefreshing()
                    self.delegate?.showEmptyState(with: .error(error))
                }
            }
        }
        
    }
    
    private func notifyFavoriteProductChanged(id: String, isFavorite: Bool) {
        NotificationCenter.default.post(
            name: .changedFavorite,
            object: nil,
            userInfo: [
                NotificationCenterOutputs.productId.rawValue: id,
                NotificationCenterOutputs.isFavorite.rawValue: isFavorite
            ]
        )
    }
    
    private func assignData() {
        
        guard !favorites.isEmpty else {
            emptyState = .noFavorites
            delegate?.showEmptyState(with: .noFavorites)
            return
        }
        
        delegate?.prepareCollectionView()
        delegate?.reloadTableView()
        
    }
    
    func refresh() {
        fetchMyFavorites()
    }
    
}
