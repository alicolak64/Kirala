//
//  SearchContracts.swift
//  Kirala
//
//  Created by Ali Çolak on 17.05.2024.
//

import UIKit

protocol SearchBuilderProtocol {
    static func build(navigationController: UINavigationController?, searchOption: SearchRouteOption) -> UIViewController
}

struct SearchBarPlaceholder {
    let text: String
    let count: Int
}

enum SearchRoute {
    case back
    case twoStepBack
    case detail(DetailArguments)
    case searchEditing(String)
    case textSearch(String)
    case auth
    case sort(SortPopupArguments, SearchViewModel)
    case pushSearchable(SearchablePopupArguments, SearchViewModel)
    case pushMinMax(MinMaxPopupArguments, SearchViewModel)
}

enum BackButtonViewLocation {
    case left
    case right
}

enum FilterRoute {
    case initial(FilterPopupArguments, CGFloat, SearchViewModel)
    case back
    case dismiss
    case pushSearchable(SearchablePopupArguments, SearchViewModel)
    case pushMinMax(MinMaxPopupArguments, SearchViewModel)
}

protocol SearchRouterProtocol {
    func navigate(to route: SearchRoute)
}

protocol FilterRouterProtocol {
    func navigate(to route: FilterRoute)
}

protocol SearchViewModelProtocol {
    
    // MARK: Dependency Properties
    var delegate: SearchViewProtocol? { get set }
    
    // MARK: Lifecycle Methods
    
    func viewDidLoad()
    func viewWillAppear()
    func viewDidLayoutSubviews()
    func viewDidAppear()
    func viewDidDisappear()
        
    // MARK: Actions
    func didTapCancelButton()
    func didTapView()
    func searchBarShouldBeginEditing() -> Bool
    func searchBarSearchButtonClicked(with query: String?)
    
    // MARK: Methods
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func cellForItem(at indexPath: IndexPath) -> SearchProductCellArguments?
    func didSelectItem(at indexPath: IndexPath)
    func sizeForItem(at indexPath: IndexPath, frame: CGSize) -> CGSize
    func didTapFavoriteButton(at indexPath: IndexPath)
    func didTapImageSliderView(at indexPath: IndexPath)
    func didTapSortButton()
    func didTapFilterButton()
    
    func numberOfFilters(in section: Int) -> Int
    func cellForFilterItem(at indexPath: IndexPath) -> FilterViewModelArguments?
    func didSelectFilterItem(at indexPath: IndexPath)
    
}

protocol SearchViewProtocol: AnyObject {
    
    // MARK: Methods
    
    func prepareNavigationBar()
    func prepareNavigationBarHeaderSearch(with text: String)
    func prepareBackNavigation(type location: BackButtonViewLocation)
    func prepareUI()
    func prepareConstraints()
    func prepareProductsCollectionView()
    func showProductsCollectionView()
    func showFilterView()
    func addBadgeCountFilterView(count: Int)
    func removeBadgeCountFilterView()
    func openSearchBar()
    func openSearchBar(with query: String)
    func setSearchBarPlaceHolder(with placeholder: String)
    func closeSearchBar()
    func addTapGesture()
    func addSwipeGesture()
    func removeSwipeGesture()
    func showEmptyState(with state: EmptyState)
    
    func showLoading()
    func hideLoading(loadResult: LoadingResult)
    func showPaginationLoading()
    func hidePaginationLoading()
    
    func reloadRows(at indexPaths: [IndexPath])
    func reloadCollectionView()
    func insertItems(at indexPaths: [IndexPath])
    func reloadFavoriteState(indexPath: IndexPath, favoriteState: FavoriteState)
    func closeExpandedCell(type: FilterType)
    func reloadFilterCell(type: FilterType)
    
    func showActionSheet(title: String, message: String, actionTitle: String, completion: @escaping () -> Void)

}



