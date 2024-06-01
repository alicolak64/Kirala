//
//  HomeContracts.swift
//  Kirala
//
//  Created by Ali Çolak on 17.05.2024.
//

import Foundation

struct DetailArguments {
    let id: String
}

struct CategorySearchArguments {
    let id: String
    let name: String
}

enum SearchRouteOption: Equatable {
    case noneSearch
    case textSearch(String)
    case categorySearch(CategorySearchArguments)
    case searchEdtiting(String)
    case headerSearch(HeaderType)
    
    static func == (lhs: SearchRouteOption, rhs: SearchRouteOption) -> Bool {
        switch (lhs, rhs) {
        case (.noneSearch, .noneSearch):
            return true
        case (.textSearch(let lhsQuery), .textSearch(let rhsQuery)):
            return lhsQuery == rhsQuery
        case (.categorySearch(let lhsArguments), .categorySearch(let rhsArguments)):
            return lhsArguments.id == rhsArguments.id
        case (.searchEdtiting(let lhsQuery), .searchEdtiting(let rhsQuery)):
            return lhsQuery == rhsQuery
        case (.headerSearch(let lhsHeaderType), .headerSearch(let rhsHeaderType)):
            return lhsHeaderType == rhsHeaderType
        default:
            return false
        }
    }
    
    static func isCategorySearch(_ option: SearchRouteOption) -> Bool {
        if case .categorySearch = option {
            return true
        }
        return false
    }
    
    static func isSearchEditing(_ option: SearchRouteOption) -> Bool {
        if case .searchEdtiting = option {
            return true
        }
        return false
    }
    
    static func isNoneSearch(_ option: SearchRouteOption) -> Bool {
        if case .noneSearch = option {
            return true
        }
        return false
    }
    
    static func isTextSearch(_ option: SearchRouteOption) -> Bool {
        if case .textSearch = option {
            return true
        }
        return false
    }
    
    static func isHeaderSearch(_ option: SearchRouteOption) -> Bool {
        if case .headerSearch = option {
            return true
        }
        return false
    }
    
}

enum HomeRoute {
    // MARK: Cases
    case detail(DetailArguments)
    case search(SearchRouteOption)
    case notifications
    case categories
    case login
}

protocol HomeRouterProtocol {
    // MARK: Methods
    func navigate(to route: HomeRoute)
}

enum HomeCollectionViewTag: Int {
    case categories = 0
    case compositionalLayout = 1
}

enum HomeCompositionalLayoutSection: Int, CaseIterable{
    case campaign = 0
    case newAdded = 1
    case bestSellers = 2
    case mostRated = 3
}

enum HeaderType {
    case newAdded
    case bestSellers
    case mostRated
}

protocol HomeViewModelProtocol {
    
    // MARK: - Dependency Properties
    var delegate: HomeViewProtocol? { get set }
    
    // MARK: - Lifecycle Methods
    func viewDidLoad()
    func viewWillAppear()
    func viewDidLayoutSubviews()
    
    // MARK: - Actions
    func didTapNotificationButton()
    func didTapSearchButton()
    func didTapAllCategoriesButton()
    
    func numberOfSections(type: HomeCollectionViewTag) -> Int
    func numberOfItemsInSection(type: HomeCollectionViewTag, section: Int) -> Int
    func didSelectItem(type: HomeCollectionViewTag, at indexPath: IndexPath)
    func sizeForHeader(type: HomeCollectionViewTag, section: Int) -> CGSize
    func cellForItem(type: HomeCollectionViewTag, at indexPath: IndexPath) -> Any?
    func headerForSection(type: HomeCollectionViewTag, section: Int) -> Any?
    func didScrollToItem(at indexPath: IndexPath)
    
    func didTapFavoriteButton(at indexPath: IndexPath)
    func didTapAllProductsButton(headerType: HeaderType)
}

protocol HomeViewProtocol: AnyObject {
    
    // MARK: - Methods
    func prepareNavigationBar()
    func prepareUI()
    func prepareCategoriesCollectionView()
    func prepareContentCompositinalLayoutCollectionView()
    func prepareConstraints()
    func configureContentCompositionalLayout()
    
    func didScrollToItem(at indexPath: IndexPath)
    
    func reloadRows(type: HomeCollectionViewTag, at indexPaths: [IndexPath])
    func reloadCollectionView(type: HomeCollectionViewTag)
    func reloadFavoriteState(indexPath: IndexPath, favoriteState: FavoriteState)
        
    func showActionSheet(title: String, message: String, actionTitle: String, completion: @escaping () -> Void)
    
}






