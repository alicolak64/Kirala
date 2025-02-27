//
//  SearchViewModel.swift
//  Kirala
//
//  Created by Ali Çolak on 17.05.2024.
//

import Foundation

struct SearchProduct: Favoritable {
    
    let id: String
    let brand: String
    let name: String
    let price: Double
    let imageUrls: [String]
    let review: ReviewProduct
    var favoriteState: FavoriteState = .nonFavorited
    
    static let imageUrls: [String] = [
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1316/product/media/images/prod/QC/20240516/05/4fe5b52b-9683-30b8-8f02-8f27427563ce/1_org_zoom.jpg",
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty523/product/media/images/20220906/10/169669516/559695008/1/1_org_zoom.jpg",
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty524/product/media/images/20220906/23/169944258/473258342/1/1_org_zoom.jpg",
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1217/product/media/images/prod/SPM/PIM/20240311/22/99113d09-65de-3c1a-af43-632c965fb05e/1_org_zoom.jpg",
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1244/product/media/images/prod/SPM/PIM/20240405/20/b0799cb4-d205-3193-be0a-7399a4929d55/1_org_zoom.jpg",
        "https://cdn.dsmcdn.com/mnresize/1200/1800/ty1187/product/media/images/prod/SPM/PIM/20240224/17/e382a0cd-ad62-3611-aa9a-14e2ce302389/1_org_zoom.jpg"
    ]
    
    static func getImageUrls() -> [String] {
        // return random count ımage urls
        let count = Int.random(in: 1...imageUrls.count)
        return Array(imageUrls.shuffled().prefix(count))
    }
    
    static let mockSearchProducts = [
        SearchProduct(id: "1", brand: "META", name: "Quest 3 128 Gb Kablosuz Vr Sanal Gerçeklik Gözlüğü", price: 20000, imageUrls: getImageUrls(), review: ReviewProduct(count: Int.random(in: 1...100), rating: Double.random(in: 1...5))),
        SearchProduct(id: "2", brand: "Fancy&Dancy", name: "Kadın Siyah Dalgıç Kumaş Özel Üretim Şık Spor Şort Etek", price: 200, imageUrls: getImageUrls(), review: ReviewProduct(count: Int.random(in: 1...100), rating: Double.random(in: 1...5))),
        SearchProduct(id: "3", brand: "MUCE", name: "Concept Siyah Cam Beyaz Çerçeve Kadın Güneş Gözlüğü Uv 400 Ultraviyole Korumalı", price: 84.90, imageUrls: getImageUrls(),review: ReviewProduct(count: Int.random(in: 1...100), rating: Double.random(in: 1...5))),
        SearchProduct(id: "4", brand: "King", name: "P-637 Grillmax Mor Izgara Ve Tost Makinesi", price: 1250, imageUrls: getImageUrls(),review: ReviewProduct(count: Int.random(in: 1...100), rating: Double.random(in: 1...5))),
        SearchProduct(id: "5", brand: "KORKMAZ", name: "A369 Demtez Elektrikli &ccedil;aydanlık Inox-siyah", price: 1746.78, imageUrls: getImageUrls(),review: ReviewProduct(count: Int.random(in: 1...100), rating: Double.random(in: 1...5))),
        SearchProduct(id: "6", brand: "Philips", name: "3000 Serisi Airfryer, 0.8kg, 4.1L Kapasite, Siyah, HD9243/90", price: 2589, imageUrls: getImageUrls(),review: ReviewProduct(count: Int.random(in: 1...100), rating: Double.random(in: 1...5)))
    ]
    
    static func getMockSearchProducts() -> [SearchProduct] {
        return mockSearchProducts.shuffled()
    }
    
}

final class SearchViewModel {
    
    // MARK: - Dependency Properties
    
    weak var delegate: SearchViewProtocol?
    private var searchOption: SearchRouteOption
    private var searchQuery: String?
    private var categorySearchArguments: CategorySearchArguments?
    
    private let router: SearchRouterProtocol
    private let filterRouter: FilterRouterProtocol
    private let authService: AuthService
    private let productService: ProductService
    private let favoriteService: FavoriteService
    
    private var products = [SearchProduct]()
    
    private var searchCount = 0
    private var productPage = 0
    private var isLastPage = false
    private var lastRequestTime: Date?
    
    private var error: ErrorResponse?
    
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
    
    private var paginationLoadingState: LoadingState = .loaded(.none) {
        didSet {
            switch paginationLoadingState {
            case .loading:
                delegate?.showPaginationLoading()
            case .loaded(_):
                delegate?.hidePaginationLoading()
            }
        }
    }
    
    private var sortOptions: [SortOption] = SortOption.makeSortOptions()
    private var filterOptions: [FilterOption] = FilterOption.makeFilterOptions()
    private var searchbalePopupOptions: [SearchablePopupType: [SearchablePopupItem]] = [:]
    private var minMaxPopupOptions: [MinMaxPopupType: [MinMaxPopupItem]] = [:]
    
    // MARK: - Initializers
    
    init(router: SearchRouterProtocol, searchOption: SearchRouteOption, filterRouter: FilterRouterProtocol, dependencies: [Dependency: Any]) {
        
        guard let authService = dependencies[.authService] as? AuthService,
              let productService = dependencies[.productService] as? ProductService,
              let favoriteService = dependencies[.favoriteService] as? FavoriteService
        else {
            fatalError("AuthService not found")
        }
        
        self.router = router
        self.searchOption = searchOption
        self.filterRouter = filterRouter
        self.authService = authService
        self.productService = productService
        self.favoriteService = favoriteService
        self.searchbalePopupOptions = Dictionary(uniqueKeysWithValues: SearchablePopupType.allCases.map { ($0, []) })
        self.minMaxPopupOptions = Dictionary(uniqueKeysWithValues: MinMaxPopupType.allCases.map { ($0, []) })
        addInitialMinMaxPopupOptions()
    }
    
    deinit {
        removeObserver()
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(favoritesChanged(_:)), name: .changedFavorite, object: nil)
    }
    
    private func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: .changedFavorite, object: nil)
    }
    
    @objc private func favoritesChanged(_ notification: Notification) {
        
        
        guard let userInfo = notification.userInfo,
              let productId = userInfo[NotificationCenterOutputs.productId.rawValue] as? String,
              let isFavorite = userInfo[NotificationCenterOutputs.isFavorite.rawValue] as? Bool,
              let index = products.firstIndex(where: { $0.id == productId })
        else {
            return
        }
                
        products[index].favoriteState = isFavorite ? .favorited : .nonFavorited
        delegate?.reloadFavoriteState(indexPath: IndexPath(row: index, section: 0), favoriteState: products[index].favoriteState)
        
    }
    
    private func addInitialSearchableFilterOptions() {
        SearchablePopupType.allCases.forEach { type in
            searchbalePopupOptions[type] = SearchablePopupArguments.mockData(type: type).items
        }
        let categories = Category.mockCategories.map { SearchablePopupItem(id: $0.id, name: $0.name, selectionState: .unselected) }
        searchbalePopupOptions[.category] = SearchablePopupArguments(
            title: Strings.Filter.category.localized,
            type: .category,
            items: categories
        ).items
    }
    
    private func addInitialMinMaxPopupOptions() {
        MinMaxPopupType.allCases.forEach { type in
            minMaxPopupOptions[type] = MinMaxPopupArguments.mockData(type: type).items
        }
    }
    
    
    
}

extension SearchViewModel: SearchViewModelProtocol {
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems(in section: Int) -> Int {
        return products.count
    }
    
    func cellForItem(at indexPath: IndexPath) -> SearchProductCellArguments? {
        guard indexPath.row < products.count else { return nil }
        let product = products[indexPath.row]
        return SearchProductCellArguments(brand: product.brand, name: product.name, imageURLs: product.imageUrls, review: product.review, price: product.price, favoriteState: product.favoriteState, indexPath: indexPath)
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        router.navigate(to: .detail(DetailArguments(id: products[indexPath.row].id)))
    }
    
    func sizeForItem(at indexPath: IndexPath, frame: CGSize) -> CGSize {
        return CGSize(width: (frame.width - 48) / 2 , height: 360)
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
        products[indexPath.row].favoriteState.toggle()
        delegate?.reloadFavoriteState(indexPath: indexPath, favoriteState: products[indexPath.row].favoriteState)
        
    }
    
    func didTapImageSliderView(at indexPath: IndexPath) {
        router.navigate(to: .detail(DetailArguments(id: products[indexPath.row].id)))
    }
    
    
    // MARK: - Lifecycle Methods
    
    func viewDidLoad() {
        
        switch searchOption {
        case .headerSearch(let headerType):
            switch headerType {
            case .newAdded:
                delegate?.prepareNavigationBarHeaderSearch(
                    with: Strings.Common.newAddeds.localized
                )
            case .bestSellers:
                delegate?.prepareNavigationBarHeaderSearch(
                    with: Strings.Common.bestSellers.localized
                )
            case .mostRated:
                delegate?.prepareNavigationBarHeaderSearch(
                    with: Strings.Common.mostRated.localized
                )
            }
        default:
            delegate?.prepareNavigationBar()
        }
        
        delegate?.prepareUI()
        
        
        switch searchOption {
        case .noneSearch:
            delegate?.prepareBackNavigation(type: .right)
        case .searchEdtiting:
            delegate?.prepareBackNavigation(type: .right)
            delegate?.prepareBackNavigation(type: .left)
        case .categorySearch, .textSearch:
            delegate?.prepareBackNavigation(type: .left)
        case .headerSearch:
            products = SearchProduct.getMockSearchProducts()
            addInitialSearchableFilterOptions()
            delegate?.prepareBackNavigation(type: .left)
            delegate?.prepareProductsCollectionView()
            delegate?.showProductsCollectionView()
            delegate?.reloadCollectionView()
            delegate?.showFilterView()
        }
        
        addObserver()
        
        delegate?.addSwipeGesture()
        switch searchOption {
        case .noneSearch:
            delegate?.openSearchBar()
            delegate?.addTapGesture()
        case .textSearch(let query):
            searchQuery = query
            getFilteredProducts(searhText: query)
        case .categorySearch(let arguments):
            categorySearchArguments = arguments
            getFilteredProducts(categoryIds: [arguments.id])
        case .searchEdtiting(let query):
            delegate?.openSearchBar(with: query)
            delegate?.addTapGesture()
        case .headerSearch(_):
            break
        }
        
    }
    
    func viewWillAppear() {
        
    }
    
    func viewDidAppear() {

        
    }
    
    func viewDidDisappear() {
        delegate?.removeSwipeGesture()
        delegate?.closeSearchBar()
    }
    
    func viewDidLayoutSubviews() {
        delegate?.prepareConstraints()
    }
    
    // MARK: - Actions
    
    func searchBarShouldBeginEditing() -> Bool {
        switch searchOption {
        case .noneSearch:
            return true
        case .textSearch(let query):
            router.navigate(to: .searchEditing(query))
            return false
        case .categorySearch(let arguments):
            router.navigate(to: .searchEditing(arguments.name))
            return false
        case .searchEdtiting(_):
            return true
        case .headerSearch(_):
            return false
        }
    }
    
    func searchBarSearchButtonClicked(with query: String?) {
        guard let query = query, !query.isEmpty else { return }
        delegate?.closeSearchBar()
        router.navigate(to: .textSearch(query))
    }
    
    func didTapCancelButton() {
        guard !SearchRouteOption.isTextSearch(searchOption) else {
            router.navigate(to: .twoStepBack)
            return
        }
        router.navigate(to: .back)
    }
    
    func didTapView() {
        delegate?.closeSearchBar()
    }
    
    func didTapSortButton() {
        router.navigate(to: .sort(
            SortPopupArguments(
                title: Strings.Filter.sort.localized,
                sortOptions: sortOptions
            ),
            self
        ))
    }
    
    func didTapFilterButton() {
        filterRouter.navigate(to: .initial(FilterPopupArguments(title: Strings.Filter.sort.localized, filterOptions: filterOptions), 550, self))
    }
    
    func numberOfFilters(in section: Int) -> Int {
        return filterOptions.count
    }
    
    func cellForFilterItem(at indexPath: IndexPath) -> FilterViewModelArguments? {
        guard indexPath.row < filterOptions.count else { return nil }
        guard let option = filterOptions[safe: indexPath.row] else { return nil }
        return FilterViewModelArguments(title: option.title, type: option.type, isAvaliableSelectedItems: !option.selectedItems.isEmpty)
    }
    
    func didSelectFilterItem(at indexPath: IndexPath) {
        guard indexPath.row < filterOptions.count else { return }
        let type = filterOptions[indexPath.row].type
        switch type {
        case .category, .brand, .city, .renter:
            router.navigate(to: .pushSearchable(SearchablePopupArguments(title: getSearchableItemTitle(with: type.convertSearchablePopupType()), type: type.convertSearchablePopupType(), items: searchbalePopupOptions[type.convertSearchablePopupType()] ?? []), self))
        case .price, .rating, .rentalPeriod:
            router.navigate(to: .pushMinMax(
                MinMaxPopupArguments(
                    title: getMinMaxItemTitle(with: type.convertMinMaxPopupType()),
                    type: type.convertMinMaxPopupType(),
                    items: minMaxPopupOptions[type.convertMinMaxPopupType()] ?? []
                ),
                self
            ))
        }
    }
    
    private func getFilteredProducts(
        pageIndex: Int = 0,
        searhText: String? = nil,
        categoryIds: [String] = [],
        brandIds: [String] = [],
        cityIds: [String] = [],
        renterIds: [String] = [],
        minPrice: Double? = nil,
        maxPrice: Double? = nil,
        minRating: Double? = nil,
        minRentalPeriod: Int? = nil,
        maxRentalPeriod: Int? = nil
    ) {
        
        if pageIndex == 0 {
            loadingState = .loading
            products.removeAll()
        } else {
            paginationLoadingState = .loading
        }
        
        productService.getFilteredProducts(
            searhText: searhText,
            categoryIds: categoryIds,
            brandIds: brandIds,
            cityIds: cityIds,
            renterIds: renterIds,
            minPrice: minPrice,
            maxPrice: maxPrice,
            minRentPeriod: minRentalPeriod,
            maxRentPeriod: maxRentalPeriod,
            pageIndex: pageIndex,
            pageSize: NetworkConstants.Constraints.paginationSize,
            token: authService.getAuthToken()
        ) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    guard let data = response.data else { return }
                    let responseProducts = data.content.products
                    self.searchCount = data.numberOfElements
                    let startIndex = self.products.count
                    let endIndex = startIndex + responseProducts.count
                    let indexPaths = (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
                    self.products.append(contentsOf: responseProducts.map {
                        let imageUrls = $0.imageUrls.map { $0 ?? String.noImageURLString }
                        let review = ReviewProduct (count: Int.random(in: 1...100), rating: Double.random(in: 1...5))
                        return SearchProduct(id: $0.id, brand: $0.brand, name: $0.name, price: $0.price, imageUrls: imageUrls, review: review, favoriteState: FavoriteState(isFavorite: $0.isFavorite))
                    })
                    
                    if let searchQuery = data.searchText {
                        self.delegate?.setSearchBarPlaceHolder(
                            with:
                                searchQuery + " | " +
                                data.numberOfElements.description + " " + Strings.Common.product.localized)
                    } else {
                        var searchQuery = ""
                        if data.content.subcategories.count == 1 {
                            searchQuery += data.content.subcategories[0].name
                        }
                        if data.content.brands.count == 1 &&
                            searchQuery.count + data.content.brands[0].name.count < 20 {
                            searchQuery += " " + data.content.brands[0].name
                        }
                        if data.content.cities.count == 1 &&
                            searchQuery.count + data.content.cities[0].name.count < 20 {
                            searchQuery += " " + data.content.cities[0].name
                        }
                        if data.content.renters.count == 1 &&
                            searchQuery.count + data.content.renters[0].name.count < 20 {
                            searchQuery += " " + data.content.renters[0].name
                        }
                        
                        self.delegate?.setSearchBarPlaceHolder(
                            with:
                                searchQuery.prefix(25) + " | " +
                                data.numberOfElements.description + " " + Strings.Common.product.localized
                        )
                    }
                    
                    if startIndex == 0 {
                        self.loadingState = .loaded(.none)
                        
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else { return }
                            self.delegate?.prepareProductsCollectionView()
                            self.delegate?.showProductsCollectionView()
                            self.delegate?.reloadCollectionView()
                            self.delegate?.showFilterView()
                            self.changeBadgeCount()
                            self.changeSearchableFilterOptions(with: data.content.subcategories.map { SearchablePopupItem(id: $0.id, name: $0.name, selectionState: SelectionState(isSelected: $0.isSelected)) }, type: .category)
                            self.changeSearchableFilterOptions(with: data.content.brands.map { SearchablePopupItem(id: $0.id, name: $0.name, selectionState: SelectionState(isSelected: $0.isSelected)) }, type: .brand)
                            self.changeSearchableFilterOptions(with: data.content.cities.map { SearchablePopupItem(id: String($0.id), name: $0.name, selectionState: SelectionState(isSelected: $0.isSelected)) }, type: .city)
                            self.changeSearchableFilterOptions(with: data.content.renters.map { SearchablePopupItem(id: $0.id, name: $0.name, selectionState: SelectionState(isSelected: $0.isSelected)) }, type: .renter)
                            self.delegate?.closeExpandedCell(type: .category)
                            self.delegate?.reloadFilterCell(type: .category)
                            self.delegate?.closeExpandedCell(type: .brand)
                            self.delegate?.reloadFilterCell(type: .brand)
                            self.delegate?.closeExpandedCell(type: .renter)
                            self.delegate?.reloadFilterCell(type: .renter)
                            self.delegate?.closeExpandedCell(type: .city)
                            self.delegate?.reloadFilterCell(type: .city)
                            self.changeBadgeCount()
                        }
                        
                    } else {
                        self.paginationLoadingState = .loaded(.none)
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else { return }
                            self.delegate?.insertItems(at: indexPaths)
                        }
                    }
                    
                    self.productPage = data.pageable.pageNumber
                    self.isLastPage = data.isLast
                    
                    
                case .failure(let error):
                    print(error)
                }
                
            }
            
        }
        
    }
    
    func scrollViewDidScroll(contentOffset: CGPoint, contentSize: CGSize, bounds: CGRect) {
        guard !isLastPage && !paginationLoadingState.isLoading() else { return }
        
        
        let contentHeight = contentSize.height
        let visibleHeight = bounds.height
        let scrollOffset = contentOffset.y
        
        let scrollPercentage = (scrollOffset + visibleHeight) / contentHeight
        
        if scrollPercentage >= NetworkConstants.Constraints.infinityScrollPercentage && products.count > 0 {
            
            let now = Date()
            
            if let lastRequestTime = lastRequestTime,  Date().timeIntervalSince(lastRequestTime) < NetworkConstants.Constraints.infinityScrollLateLimitSecond{
                return
            }
            
            getFilteredProducts(
                pageIndex: productPage + 1,
                searhText: searchQuery,
                categoryIds: filterOptions[FilterType.category.rawValue].selectedIds,
                brandIds: filterOptions[FilterType.brand.rawValue].selectedIds,
                cityIds: filterOptions[FilterType.city.rawValue].selectedIds,
                renterIds: filterOptions[FilterType.renter.rawValue].selectedIds
            )
            
            lastRequestTime = now
            
        }
        
    }
    
}

extension SearchViewModel: SortPopupDelegate {
    
    func didSelectSortOption(_ sortType: SortType) {
        let oldSortOptionType = sortOptions.first { $0.selectionState == .selected }?.sortType
        sortOptions = sortOptions.map { option in
            var updatedOption = option
            if option.sortType == sortType {
                updatedOption.selectionState = .selected
            } else if option.sortType == oldSortOptionType {
                updatedOption.selectionState = .unselected
            }
            return updatedOption
        }
        
    }
    
}

extension SearchViewModel: FilterPopupDelegate {
    
    private func getSearchableItemTitle(with type: SearchablePopupType) -> String {
        switch type {
        case .category:
            return  Strings.Filter.category.localized
        case .brand:
            return Strings.Filter.brand.localized
        case .city:
            return Strings.Filter.city.localized
        case .renter:
            return Strings.Filter.renter.localized
        }
    }
    
    private func getMinMaxItemTitle(with type: MinMaxPopupType) -> String {
        switch type {
        case .price:
            return Strings.Filter.price.localized
        case .rating:
            return Strings.Filter.rating.localized
        case .rentalPeriod:
            return Strings.Filter.rentalPeriod.localized
        }
    }
    
    func didSelectFilterOption(_ option: FilterType) {
        switch option {
        case .category, .brand, .city, .renter:
            filterRouter.navigate(to: .pushSearchable(
                SearchablePopupArguments(
                    title: getSearchableItemTitle(with: option.convertSearchablePopupType()),
                    type: option.convertSearchablePopupType(),
                    items: searchbalePopupOptions[option.convertSearchablePopupType()] ?? []),
                self
            ))
        case .price, .rating, .rentalPeriod:
            filterRouter.navigate(to: .pushMinMax(
                MinMaxPopupArguments(
                    title: getMinMaxItemTitle(with: option.convertMinMaxPopupType()),
                    type: option.convertMinMaxPopupType(),
                    items: minMaxPopupOptions[option.convertMinMaxPopupType()] ?? []
                ),
                self
            ))
        }
        
    }
    
    func didTapClearFilterButton() {
        SearchablePopupType.allCases.forEach { type in
            let selectedItemsCount = searchbalePopupOptions[type]?.filter { $0.selectionState == .selected }.count ?? 0
            if selectedItemsCount == 0 { return }
            filterOptions = filterOptions.map { option in
                var updatedOption = option
                if option.type == type.convertFilterType() {
                    updatedOption.selectedItems = []
                }
                return updatedOption
            }
            searchbalePopupOptions[type] = searchbalePopupOptions[type]?.map { item in
                let updatedItem = item
                updatedItem.selectionState = .unselected
                return updatedItem
            }
        }
        
        SearchablePopupType.allCases.forEach { type in
            notifySearchableFilterOptionsDidChange(type: type, items: [])
        }
        
        MinMaxPopupType.allCases.forEach { type in
            let selectedItemsCount = minMaxPopupOptions[type]?.filter { $0.selectionState == .selected }.count ?? 0
            if selectedItemsCount == 0 { return }
            filterOptions = filterOptions.map { option in
                var updatedOption = option
                if option.type == type.convertFilterType() {
                    updatedOption.selectedItems = []
                }
                return updatedOption
            }
            minMaxPopupOptions[type] = minMaxPopupOptions[type]?.map { item in
                var updatedItem = item
                updatedItem.selectionState = .unselected
                return updatedItem
            }
            minMaxPopupOptions[type]?.removeAll(where : {$0.minMax.isCustom == true})
        }
        
        MinMaxPopupType.allCases.forEach { type in
            notifyMinMaxFilterOptionsDidChange(type: type, items: [])
        }
        
        delegate?.removeBadgeCountFilterView()
        
        FilterType.allCases.forEach { type in
            delegate?.reloadFilterCell(type: type)
        }
        
    }
    
    func didTapDismissButton() {
        filterRouter.navigate(to: .dismiss)
    }
    
}

extension SearchViewModel: SearchablePopupDelegate {
    
    func didTapBackButton() {
        filterRouter.navigate(to: .back)
    }
    
    func viewWillDisappear(with selectedItems: [SearchablePopupItem], type: SearchablePopupType) {
        
        let oldFilterOptions = filterOptions[type.convertFilterType().rawValue]
        changeSearchableFilterOptions(with: selectedItems, type: type)
        changeBadgeCount()
        delegate?.closeExpandedCell(type: type.convertFilterType())
        delegate?.reloadFilterCell(type: type.convertFilterType())
        
        if oldFilterOptions != filterOptions[type.convertFilterType().rawValue] {
            getFilteredProducts(
                searhText: searchQuery,
                categoryIds: filterOptions[FilterType.category.rawValue].selectedIds,
                brandIds: filterOptions[FilterType.brand.rawValue].selectedIds,
                cityIds: filterOptions[FilterType.city.rawValue].selectedIds,
                renterIds: filterOptions[FilterType.renter.rawValue].selectedIds
            )
        }
        
        
        
    }
    
    
    func didTapApplyButton(with selectedItems: [SearchablePopupItem], type: SearchablePopupType) {
        filterRouter.navigate(to: .back)
    }
    
    private func changeBadgeCount() {
        let badgeCount = filterOptions.reduce(0) { result, option in
            result + (option.type == .price || option.type == .rating || option.type == .rentalPeriod ? (option.selectedItems.isEmpty ? 0 : 1) : option.selectedItems.count)
        }
        
        if badgeCount == 0 {
            delegate?.removeBadgeCountFilterView()
        } else {
            delegate?.addBadgeCountFilterView(count: badgeCount)
        }
    }
    
    private func changeSearchableFilterOptions(with items: [SearchablePopupItem], type: SearchablePopupType) {
        
        searchbalePopupOptions[type] = items
        
        let selectedItems = items.filter { $0.selectionState == .selected }
        
        filterOptions = filterOptions.map { option in
            var updatedOption = option
            if option.type == type.convertFilterType() {
                updatedOption.selectedItems = selectedItems.map { $0.name }
                updatedOption.selectedIds = selectedItems.map { $0.id }
            }
            return updatedOption
        }
        
        
        notifySearchableFilterOptionsDidChange(type: type, items: selectedItems.map { $0.name })
    }
    
    private func notifySearchableFilterOptionsDidChange(type: SearchablePopupType, items: [String]) {
        NotificationCenter.default.post(
            name: .searchableFilterOptionsDidChange,
            object: nil,
            userInfo: [
                NotificationCenterOutputs.type.rawValue: type.convertFilterType(),
                NotificationCenterOutputs.items.rawValue: items
            ]
        )
    }
    
}

extension SearchViewModel: MinMaxPopupDelegate {
    
    func didTapApplyButton(with items: [MinMaxPopupItem], type: MinMaxPopupType) {
        filterRouter.navigate(to: .back)
    }
    
    func viewWillDisappear(with items: [MinMaxPopupItem], type: MinMaxPopupType) {
        changeMinMaxPopupOptions(with: items, type: type)
        changeBadgeCount()
        delegate?.closeExpandedCell(type: type.convertFilterType())
        delegate?.reloadFilterCell(type: type.convertFilterType())
    }
    
    
    private func changeMinMaxPopupOptions(with items: [MinMaxPopupItem], type: MinMaxPopupType) {
        
        if let selectedItem = items.first(where: { $0.selectionState == .selected }) {
            if let min = selectedItem.minMax.min, let max = selectedItem.minMax.max {
                if min > max {
                    return
                }
            }
        }
        
        let selectedItem = items.first(where: { $0.selectionState == .selected })
        
        minMaxPopupOptions[type] = items
        
        guard let selectedItem = selectedItem else {
            filterOptions[type.convertFilterType().rawValue].selectedItems = []
            notifyMinMaxFilterOptionsDidChange(type: type, items: filterOptions[type.convertFilterType().rawValue].selectedItems)
            return
        }
        
        let item = selectedItem.minMax
        
        switch type {
        case .price, .rentalPeriod:
            if item.isCustom {
                if item.min != nil && item.max == nil {
                    filterOptions[type.convertFilterType().rawValue].selectedItems = [
                        Strings.Filter.min.localized,
                        item.min?.formatIntAndString ?? ""]
                } else if item.min == nil && item.max != nil {
                    filterOptions[type.convertFilterType().rawValue].selectedItems = [
                        Strings.Filter.max.localized,
                        item.max?.formatIntAndString ?? ""]
                } else {
                    filterOptions[type.convertFilterType().rawValue].selectedItems = [item.min?.formatIntAndString ?? "", "-" ,  item.max?.formatIntAndString ?? ""]
                }
            } else {
                filterOptions[type.convertFilterType().rawValue].selectedItems = [item.min?.formatIntAndString ?? "", "-" ,  item.max?.formatIntAndString ?? ""]
            }
        case .rating:
            guard let minStar = item.min else { return }
            filterOptions[type.convertFilterType().rawValue].selectedItems = [minStar.formatIntAndString, Strings.Filter.starAndAbove.localized]
        }
        
        
        
        notifyMinMaxFilterOptionsDidChange(type: type, items: filterOptions[type.convertFilterType().rawValue].selectedItems)
    }
    
    private func notifyMinMaxFilterOptionsDidChange(type: MinMaxPopupType, items: [String]) {
        NotificationCenter.default.post(
            name: .minMaxFilterOptionsDidChange,
            object: nil,
            userInfo: [
                NotificationCenterOutputs.type.rawValue: type.convertFilterType(),
                NotificationCenterOutputs.items.rawValue: items
            ]
        )
    }
    
}
