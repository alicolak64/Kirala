//
//  HomeViewModel.swift
//  Kirala
//
//  Created by Ali Çolak on 17.05.2024.
//

import Foundation

struct Category: Selectable {
    let name: String
    let id: String
    var selectionState: SelectionState = .unselected
    
    static let mockCategories = [
        Category(name: "Kıyafet", id: "1", selectionState: .selected),
        Category(name: "Ayakkabı", id: "2"),
        Category(name: "Aksesuar", id: "3"),
        Category(name: "Çanta", id: "4"),
        Category(name: "Saat", id: "5"),
        Category(name: "Giyim", id: "6"),
        Category(name: "Elektronik", id: "7"),
        Category(name: "Kozmetik", id: "8"),
        Category(name: "Spor", id: "9"),
        Category(name: "Ev", id: "10"),
        Category(name: "Oyuncak", id: "11"),
        Category(name: "Kitap", id: "12"),
        Category(name: "Hediye", id: "13"),
        Category(name: "Ofis", id: "14"),
        Category(name: "Süpermarket", id: "15")
    ]
    
}

struct Campaign {
    let id: String
    let url: String
}

struct Product: Favoritable {
    
    let brand: String
    let name: String
    let price: String
    let imageUrl: String
    let id: String
    var favoriteState: FavoriteState = .nonFavorited

    static let mockProducts = [
        Product(brand: "META", name: "Quest 3 128 Gb Kablosuz Vr Sanal Gerçeklik Gözlüğü", price: "20000 TL", imageUrl: "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1316/product/media/images/prod/QC/20240516/05/4fe5b52b-9683-30b8-8f02-8f27427563ce/1_org_zoom.jpg", id: "1"),
        Product(brand: "Fancy&Dancy", name: "Kadın Siyah Dalgıç Kumaş Özel Üretim Şık Spor Şort Etek", price: "200 TL", imageUrl: "https://cdn.dsmcdn.com/mnresize/1200/1800/ty523/product/media/images/20220906/10/169669516/559695008/1/1_org_zoom.jpg", id: "2"),
        Product(brand: "MUCE", name: "Concept Siyah Cam Beyaz Çerçeve Kadın Güneş Gözlüğü Uv 400 Ultraviyole Korumalı", price: "84,90 TL", imageUrl: "https://cdn.dsmcdn.com/mnresize/1200/1800/ty524/product/media/images/20220906/23/169944258/473258342/1/1_org_zoom.jpg", id: "3"),
        Product(brand: "King", name: "P-637 Grillmax Mor Izgara Ve Tost Makinesi", price: "1.250 TL", imageUrl: "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1217/product/media/images/prod/SPM/PIM/20240311/22/99113d09-65de-3c1a-af43-632c965fb05e/1_org_zoom.jpg", id: "4"),
        Product(brand: "KORKMAZ", name: "A369 Demtez Elektrikli &ccedil;aydanlık Inox-siyah", price: "1.746,78 TL", imageUrl: "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1244/product/media/images/prod/SPM/PIM/20240405/20/b0799cb4-d205-3193-be0a-7399a4929d55/1_org_zoom.jpg", id: "5"),
        Product(brand: "Philips", name: "3000 Serisi Airfryer, 0.8kg, 4.1L Kapasite, Siyah, HD9243/90", price: "₺2.589 TL", imageUrl: "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1187/product/media/images/prod/SPM/PIM/20240224/17/e382a0cd-ad62-3611-aa9a-14e2ce302389/1_org_zoom.jpg", id: "6"),
    ]
    
}

final class HomeViewModel {
    
    // MARK: - Dependency Properties
    
    weak var delegate: HomeViewProtocol?
    
    private let router: HomeRouterProtocol
    private let authService: AuthService
    private let categoryService: CategoryService
    private let productService: ProductService
    
    // MARK: - Properties
    
    private var categories = [Category]()
    
    private var selectedCategoryIndex: Int = 0
    
    private var campaigns = [Campaign]()
        
    private var campaignTimer: Timer?
    
    private var visibleCampaignIndexPath = IndexPath(row: 0, section: HomeCompositionalLayoutSection.campaign.rawValue)
    
    private var newsAddedProducts: [Product] = Product.mockProducts
    
    private var bestSellersProducts: [Product] = Product.mockProducts.shuffled()
    
    private var mostRatedProducts: [Product] = Product.mockProducts.shuffled()
    
    private let dispatchGroup = DispatchGroup()
    
    private var loadingState: LoadingState = .loading {
        didSet {
            switch loadingState {
            case .loading:
                delegate?.showLoading()
            case .loaded(let result):
                self.delegate?.hideLoading(loadResult: result)
            }
        }
    }
    
    // MARK: - Initializers
    
    init(router: HomeRouterProtocol, dependencies: [Dependency: Any]) {
       
        guard let authService = dependencies[.authService] as? AuthService,
              let categoryService = dependencies[.categoryService] as? CategoryService,
              let productService = dependencies[.productService] as? ProductService
        else {
            fatalError("Dependencies could not be resolved")
        }
        
        self.router = router
        self.authService = authService
        self.categoryService = categoryService
        self.productService = productService
        
    }
    
    private func startTimer() {
        campaignTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(campaignTimerAction), userInfo: nil, repeats: true)
    }
    
    // MARK: - Actions
    
    @objc private func campaignTimerAction() {
        visibleCampaignIndexPath.row += 1
        if visibleCampaignIndexPath.row == campaigns.count {
            visibleCampaignIndexPath.row = 0
        }
        delegate?.reloadRows(type: .compositionalLayout, at: [visibleCampaignIndexPath])
    }
    
}

extension HomeViewModel: HomeViewModelProtocol {
    
    // MARK: - Lifecycle Methods
    
    func viewDidLoad() {
        
        delegate?.prepareNavigationBar()
        delegate?.prepareUI()
        
        delegate?.prepareCategoriesCollectionView()
        delegate?.prepareContentCompositinalLayoutCollectionView()
        delegate?.configureContentCompositionalLayout()
        
        fetchInitialData()
        
    }
    
    func viewWillAppear() {
        
    }
    
    func viewDidLayoutSubviews() {
        delegate?.prepareConstraints()
    }
    
    // MARK: - Setups
    
    private func fetchInitialData() {
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.fetchCampaigns()
            self.fetchCategories()
            
            self.dispatchGroup.notify(queue: .main) {
                self.prepareInitialConfig()
                self.loadingState = .loaded(.none)
            }
        }
        
    }
    
    private func fetchCampaigns() {
        dispatchGroup.enter()
        categoryService.getCampaignList { [weak self] result in
            defer { self?.dispatchGroup.leave() }
            guard let self = self else { return }
            switch result {
            case .success(let campaigns):
                guard let campaigns = campaigns.data else { return }
                self.campaigns = campaigns.map { Campaign(id: $0.id, url: $0.imageUrl) }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchCategories() {
        dispatchGroup.enter()
        categoryService.getCategoryList { [weak self] result in
            defer { self?.dispatchGroup.leave() }
            guard let self = self else { return }
            switch result {
            case .success(let categories):
                guard let categories = categories.data else { return }
                self.categories = categories.map { Category(name: $0.name, id: $0.id) }
                self.categories.insert(Category(name: Strings.Ad.all.localized, id: "0", selectionState: .selected), at: 0)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func prepareInitialConfig() {
        delegate?.reloadCollectionView(type: .categories)
        delegate?.reloadCollectionView(type: .compositionalLayout)
        startTimer()
    }
    
    // MARK: - Actions
    
    func didTapNotificationButton() {
        router.navigate(to: .notifications)
    }
    
    func didTapSearchButton() {
        router.navigate(to: .search(.noneSearch))
    }
    
    func didTapAllCategoriesButton() {
        router.navigate(to: .categories)
    }
    
    func didTapAllProductsButton(headerType: HeaderType) {
        router.navigate(to: .search(.headerSearch(headerType)))
    }
    
    // MARK: - Category CollectionView Methods
    
    func numberOfSections(type: HomeCollectionViewTag) -> Int {
        switch type {
        case .categories:
            return 1
        case .compositionalLayout:
            return HomeCompositionalLayoutSection.allCases.count
        }
    }
    
    func numberOfItemsInSection(type: HomeCollectionViewTag, section: Int) -> Int {
        switch type {
        case .categories:
            return categories.count
        case .compositionalLayout:
            guard let section = HomeCompositionalLayoutSection(rawValue: section) else { return 0 }
            switch section {
            case .campaign:
                return campaigns.count
            case .newAdded:
                return newsAddedProducts.count
            case .bestSellers:
                return bestSellersProducts.count
            case .mostRated:
                return mostRatedProducts.count
            }
        }
    }
    
    func sizeForHeader(type: HomeCollectionViewTag, section: Int) -> CGSize {
        switch type {
        case .categories:
            return CGSize(width: 125, height: 0)
        case .compositionalLayout:
            return .zero
        }
    }
    
    func didSelectItem(type: HomeCollectionViewTag, at indexPath: IndexPath) {
        switch type {
        case .categories:
            let oldIndex = selectedCategoryIndex
            categories[selectedCategoryIndex].selectionState.toggle()
            categories[indexPath.row].selectionState.toggle()
            selectedCategoryIndex = indexPath.row
            delegate?.reloadRows(type: .categories, at: [IndexPath(row: oldIndex, section: 0), indexPath])
        case .compositionalLayout:
            switch HomeCompositionalLayoutSection(rawValue: indexPath.section) {
            case .campaign:
                print("Campaign with index \(indexPath.row) tapped")
            case .newAdded:
                router.navigate(to: .detail(DetailArguments(id: "1")))
            case .bestSellers:
                router.navigate(to: .detail(DetailArguments(id: "1")))
            case .mostRated:
                router.navigate(to: .detail(DetailArguments(id: "1")))
            case .none:
                break
            }
        }
    }
    
    func cellForItem(type: HomeCollectionViewTag, at indexPath: IndexPath) -> Any? {
        switch type {
        case .categories:
            return cellForItemCategory(at: indexPath)
        case .compositionalLayout:
            
            switch HomeCompositionalLayoutSection(rawValue: indexPath.section) {
            case .campaign:
                return cellForItemCampaign(at: indexPath)
            case .newAdded:
                return cellForItemNewsAddedProduct(at: indexPath)
            case .bestSellers:
                return cellForItemBestSellersProduct(at: indexPath)
            case .mostRated:
                return cellForItemMostRatedProduct(at: indexPath)
            case .none:
                return nil
            }
        }
    }
    
    func headerForSection(type: HomeCollectionViewTag, section: Int) -> Any? {
        switch type {
        case .categories:
            return headerForSectionCategories()
        case .compositionalLayout:
            switch HomeCompositionalLayoutSection(rawValue: section) {
            case .campaign:
                return nil
            case .newAdded:
                return headerForSectionNewAdded()
            case .bestSellers:
                return headerForSectionBestSellers()
            case .mostRated:
                return headerForSectionMostRated()
            case .none:
                return nil
            }
        }
    }
    
    func didScrollToItem(at indexPath: IndexPath) {
        guard visibleCampaignIndexPath != indexPath else { return }
        visibleCampaignIndexPath = indexPath
        campaignTimer?.invalidate()
        startTimer()
    }
    
    private func cellForItemCategory(at indexPath: IndexPath) -> CategoryCellArguments? {
        let category = categories[indexPath.row]
        return CategoryCellArguments(name: category.name, selectionState: category.selectionState)
    }
    
    private func cellForItemCampaign(at indexPath: IndexPath) -> CampaignCellArguments? {
        let campaign = campaigns[indexPath.row]
        return CampaignCellArguments(imageUrl: campaign.url, index: indexPath.row, count: campaigns.count)
    }
    
    private func cellForItemNewsAddedProduct(at indexPath: IndexPath) -> ProductCellArguments? {
        let product = newsAddedProducts[indexPath.row]
        return ProductCellArguments(brand: product.brand, name: product.name, imageURL: product.imageUrl, price: product.price, favoriteState: product.favoriteState, indexPath: indexPath)
    }
    
    private func cellForItemBestSellersProduct(at indexPath: IndexPath) -> ProductCellArguments? {
        let product = bestSellersProducts[indexPath.row]
        return ProductCellArguments(brand: product.brand, name: product.name, imageURL: product.imageUrl, price: product.price, favoriteState: product.favoriteState, indexPath: indexPath)
    }
    
    private func cellForItemMostRatedProduct(at indexPath: IndexPath) -> ProductCellArguments? {
        let product = mostRatedProducts[indexPath.row]
        return ProductCellArguments(brand: product.brand, name: product.name, imageURL: product.imageUrl, price: product.price, favoriteState: product.favoriteState, indexPath: indexPath)
    }
    
    func headerForSectionCategories() -> CategoriesHeaderArguments? {
        CategoriesHeaderArguments(
            name: Strings.Common.categories.localized,
            symbol: Symbols.magnifyingglass
        )
    }
    
    func headerForSectionNewAdded() -> ProductsHeaderArguments? {
        ProductsHeaderArguments(
            headerType: .newAdded,
            title: Strings.Common.newAddeds.localized,
            actionTitle: Strings.Common.seeAll.localized
        )
    }
    
    func headerForSectionBestSellers() -> ProductsHeaderArguments? {
        ProductsHeaderArguments(
            headerType: .bestSellers,
            title: Strings.Common.bestSellers.localized,
            actionTitle: Strings.Common.seeAll.localized
        )
    }
    
    func headerForSectionMostRated() -> ProductsHeaderArguments? {
        ProductsHeaderArguments(
            headerType: .bestSellers,
            title: Strings.Common.mostRated.localized,
            actionTitle: Strings.Common.seeAll.localized
        )
    }
    
    func didTapFavoriteButton(at indexPath: IndexPath) {
        
        guard authService.isLoggedIn else {
            
            delegate?.showActionSheet(
                title: Strings.Alert.noLoginTitle.localized,
                message: Strings.Alert.noLoginFavoriteProductMessage.localized,
                actionTitle: Strings.Alert.noLoginAction.localized,
                completion: { [weak self] in
                    self?.router.navigate(to: .auth)
                }
                
            )
            
            return
        
        }
        
        switch HomeCompositionalLayoutSection(rawValue: indexPath.section) {
        case .campaign:
            break
        case .newAdded:
            newsAddedProducts[indexPath.row].toggleFavorite()
            delegate?.reloadFavoriteState(indexPath: indexPath, favoriteState: newsAddedProducts[indexPath.row].favoriteState)
        case .bestSellers:
            bestSellersProducts[indexPath.row].toggleFavorite()
            delegate?.reloadFavoriteState(indexPath: indexPath, favoriteState: bestSellersProducts[indexPath.row].favoriteState)
        case .mostRated:
            mostRatedProducts[indexPath.row].toggleFavorite()
            delegate?.reloadFavoriteState(indexPath: indexPath, favoriteState: mostRatedProducts[indexPath.row].favoriteState)
        case .none:
            break
        }
    }
    
    func refresh() {
        
    }
    
    func didTapEmptyStateActionButton() {
        print("didTapEmptyStateActionButton")
    }
    
}
