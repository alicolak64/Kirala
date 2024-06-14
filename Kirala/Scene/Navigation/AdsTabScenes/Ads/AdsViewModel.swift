//
//  AdsViewModel.swift
//  Kirala
//
//  Created by Ali Çolak on 6.06.2024.
//

import Foundation

final class AdsViewModel {
    
    // MARK: - Dependency Properties
    
    weak var delegate: AdsViewProtocol?
    
    private let router: AdsRouterProtocol
    private let authService: AuthService
    private let productService: ProductService
    
    private var ads = [MyProductResponse]()
    private var filteredAds = [MyProductResponse]()
    private var isSearchActive: Bool = false
    
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
    
    init(router: AdsRouterProtocol, dependencies: [Dependency: Any]) {
        guard let authService = dependencies[.authService] as? AuthService,
              let productService = dependencies[.productService] as? ProductService
        else {
            fatalError("AuthService not found")
        }
        self.router = router
        self.authService = authService
        self.productService = productService
    }
    
    deinit {
        removeObserver()
    }
    
    // MARK: - Private Functions
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(productsChanged(_:)), name: .changedProduct, object: nil)
    }
 
    private func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: .changedProduct, object: nil)
    }
    
    @objc private func productsChanged(_ notification: Notification) {
        print("Products changed")
        guard let userInfo = notification.userInfo,
              let productId = userInfo[NotificationCenterOutputs.productId.rawValue] as? String else {
            return
        }
        
        fetchMyAds()

    }
    
    private func getItems() -> [MyProductResponse] {
        isSearchActive ? filteredAds : ads
    }
    
}

extension AdsViewModel: AdsViewModelProtocol {
    
    
    // MARK: - Lifecycle Methods
    
    func viewDidLoad() {
        delegate?.prepareNavigationBar()
        delegate?.prepareUI()
        delegate?.addRefreshControl()
        
        guard authService.isLoggedIn else {
            return
        }
        
        addObserver()
        fetchMyAds()
        
    }
    
    func viewWillAppear() {
        guard authService.isLoggedIn else {
            delegate?.showEmptyState(with: .noLoginAds)
            emptyState = .noLoginAds
            return
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
        case .noAds:
            didTapAddAdButton()
        case .error:
            fetchMyAds()
        case .noLoginAds:
            router.navigate(to: .auth)
        default:
            break
        }
        
    }
    
    func didTapAddAdButton() {
        router.navigate(to: .add(.addAd))
    }
    
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfRows(in section: Int) -> Int {
        getItems().count
    }
    
    func cellForRow(at indexPath: IndexPath) -> AdCellArguments? {
        guard getItems().indices.contains(indexPath.row) else {
            return nil
        }
        
        let ad = getItems()[indexPath.row]
        
        if let imageUrl = ad.imageUrl {
            return AdCellArguments(brand: ad.brand, name: ad.name, imageUrl: imageUrl, price: ad.price.toString())
        } else {
            return AdCellArguments(brand: ad.brand, name: ad.name, imageUrl: String.noImageURLString, price: ad.price.toString())
        }
        
        
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        
        guard getItems().indices.contains(indexPath.row) else {
            return
        }
        
        let argument = EditAddAdArguments(id: getItems()[indexPath.row].id)
        
        router.navigate(to: .add(.editAd(argument)))
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func searchTextDidChange(_ searchText: String) {
        isSearchActive = !searchText.trimmed.isEmpty
        filteredAds = ads.filter {
            $0.name.lowercased().contains(searchText.lowercased()) || $0.brand.lowercased().contains(searchText.lowercased())
        }
        delegate?.reloadTableView()
    }
    
    private func fetchMyAds() {
        
        guard let token = authService.getAuthToken() else { return }
        
        loadingState = .loading
        
        productService.getProductListByUser(token: token) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    guard let data = response.data else { return }
                    self.loadingState = .loaded(.none)
                    self.ads = data
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
    
    private func assignData() {
        
        delegate?.addAddAdButtonNavigationItem()
        
        guard !ads.isEmpty else {
            emptyState = .noAds
            delegate?.showEmptyState(with: .noAds)
            return
        }
        
        delegate?.prepareTableView()
        delegate?.reloadTableView()
        
    }
    
    func refresh() {
        fetchMyAds()
    }
    
}
