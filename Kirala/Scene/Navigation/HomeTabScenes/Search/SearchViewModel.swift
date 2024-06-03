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
    
    private let router: SearchRouterProtocol
    private let filterRouter: FilterRouterProtocol
    private let authService: AuthService
    
    private var products: [SearchProduct] = SearchProduct.mockSearchProducts
    
    private var searchCount: Int = Int.random(in: 1...100)
    
    private var sortOptions: [SortOption] = SortOption.makeSortOptions()
    private var filterOptions: [FilterOption] = FilterOption.makeFilterOptions()
    private var searchbalePopupOptions: [SearchablePopupType: [SearchablePopupItem]] = [:]
    private var minMaxPopupOptions: [MinMaxPopupType: [MinMaxPopupItem]] = [:]
    
    // MARK: - Initializers
    
    init(router: SearchRouterProtocol, searchOption: SearchRouteOption, authService: AuthService, filterRouter: FilterRouterProtocol) {
        self.router = router
        self.searchOption = searchOption
        self.authService = authService
        self.filterRouter = filterRouter
        self.searchbalePopupOptions = Dictionary(uniqueKeysWithValues: SearchablePopupType.allCases.map { ($0, []) })
        self.minMaxPopupOptions = Dictionary(uniqueKeysWithValues: MinMaxPopupType.allCases.map { ($0, []) })
        addInitialSearchableFilterOptions()
        addInitialMinMaxPopupOptions()
    }
    
    private func addInitialSearchableFilterOptions() {
        SearchablePopupType.allCases.forEach { type in
            searchbalePopupOptions[type] = SearchablePopupArguments.mockData(type: type).items
        }
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
                title: Localization.alert.localizedString(for: "NO_LOGIN_TITLE"),
                message: Localization.alert.localizedString(for: "NO_LOGIN_FAVORITE_PRODUCT_MESSAGE"),
                actionTitle: Localization.alert.localizedString(for: "NO_LOGIN_ACTION"),
                completion: { [weak self] in
                    self?.router.navigate(to: .auth)
                }
                
            )
            
            return
        
        }
        
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
                delegate?.prepareNavigationBarHeaderSearch(with: Localization.common.localizedString(for: "NEW_ADDEDS"))
            case .bestSellers:
                delegate?.prepareNavigationBarHeaderSearch(with: Localization.common.localizedString(for: "BEST_SELLERS"))
            case .mostRated:
                delegate?.prepareNavigationBarHeaderSearch(with: Localization.common.localizedString(for: "MOST_RATED"))
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
        case .categorySearch, .headerSearch, .textSearch:
            delegate?.prepareBackNavigation(type: .left)
            delegate?.prepareProductsCollectionView()
            delegate?.showProductsCollectionView()
            delegate?.showFilterView()
        }
        
    }
    
    func viewWillAppear() {
        
    }
    
    func viewDidAppear() {
        delegate?.addSwipeGesture()
        switch searchOption {
        case .noneSearch:
            delegate?.openSearchBar()
            delegate?.addTapGesture()
        case .textSearch(let query):
            searchQuery = query
            delegate?.setSearchBarPlaceHolder(with: query + " | " + searchCount.description + " " + Localization.common.localizedString(for: "PRODUCT"))
        case .categorySearch(let arguments):
            searchQuery = arguments.name
            delegate?.setSearchBarPlaceHolder(with: arguments.name + " | " + searchCount.description + " " + Localization.common.localizedString(for: "PRODUCT"))
        case .searchEdtiting(let query):
            delegate?.openSearchBar(with: query)
            delegate?.addTapGesture()
        case .headerSearch(_):
            break
        }
        
    }
    
    func viewDidDisappear() {
        delegate?.removeSwipeGesture()
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
        router.navigate(to: .sort(SortPopupArguments(title: Localization.filter.localizedString(for: "SORT"), sortOptions: sortOptions), self))
    }
    
    func didTapFilterButton() {
        filterRouter.navigate(to: .initial(FilterPopupArguments(title: Localization.filter.localizedString(for: "FILTER"), filterOptions: filterOptions), 550, self))
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
            return Localization.filter.localizedString(for: "CATEGORY")
        case .brand:
            return Localization.filter.localizedString(for: "BRAND")
        case .city:
            return Localization.filter.localizedString(for: "CITY")
        case .renter:
            return Localization.filter.localizedString(for: "RENTER")
        }
    }
    private func getMinMaxItemTitle(with type: MinMaxPopupType) -> String {
        switch type {
        case .price:
            return Localization.filter.localizedString(for: "PRICE")
        case .rating:
            return Localization.filter.localizedString(for: "RATING")
        case .rentalPeriod:
            return Localization.filter.localizedString(for: "RENTAL_PERIOD")
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
            notifyMinMaxPopupOptionsDidChange(type: type, items: [])
        }
        
        delegate?.removeBadgeCountFilterView()
            
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
        changeSearchableFilterOptions(with: selectedItems, type: type)
        changeBadgeCount()
        delegate?.closeExpandedCell(type: type.convertFilterType())
        delegate?.reloadFilterCell(type: type.convertFilterType())
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
            }
            return updatedOption
        }
        notifySearchableFilterOptionsDidChange(type: type, items: selectedItems.map { $0.name })
    }
    
    private func notifySearchableFilterOptionsDidChange(type: SearchablePopupType, items: [String]) {
        NotificationCenter.default.post(name: .searchableFilterOptionsDidChange, object: nil, userInfo: ["type": type.convertFilterType(), "items": items])
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
            notifyMinMaxPopupOptionsDidChange(type: type, items: filterOptions[type.convertFilterType().rawValue].selectedItems)
            return
        }
        
        let item = selectedItem.minMax
        
        switch type {
        case .price, .rentalPeriod:
            if item.isCustom {
                if item.min != nil && item.max == nil {
                    filterOptions[type.convertFilterType().rawValue].selectedItems = [ Localization.filter.localizedString(for: "MIN"), item.min?.formatIntAndString ?? ""]
                } else if item.min == nil && item.max != nil {
                    filterOptions[type.convertFilterType().rawValue].selectedItems = [ Localization.filter.localizedString(for: "MAX"), item.max?.formatIntAndString ?? ""]
                } else {
                    filterOptions[type.convertFilterType().rawValue].selectedItems = [item.min?.formatIntAndString ?? "", "-" ,  item.max?.formatIntAndString ?? ""]
                }
            } else {
                filterOptions[type.convertFilterType().rawValue].selectedItems = [item.min?.formatIntAndString ?? "", "-" ,  item.max?.formatIntAndString ?? ""]
            }
        case .rating:
            guard let minStar = item.min else { return }
            filterOptions[type.convertFilterType().rawValue].selectedItems = [minStar.formatIntAndString, Localization.filter.localizedString(for: "STAR_AND_ABOVE")]
        }
        
        
        
        notifyMinMaxPopupOptionsDidChange(type: type, items: filterOptions[type.convertFilterType().rawValue].selectedItems)
    }
    
    private func notifyMinMaxPopupOptionsDidChange(type: MinMaxPopupType, items: [String]) {
        NotificationCenter.default.post(name: .minMaxFilterOptionsDidChange, object: nil, userInfo: ["type": type.convertFilterType(), "items": items])
    }
    
}
