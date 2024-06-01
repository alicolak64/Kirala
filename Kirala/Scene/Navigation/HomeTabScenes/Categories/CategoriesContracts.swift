//
//  CategoriesContracts.swift
//  Kirala
//
//  Created by Ali Çolak on 21.05.2024.
//

import UIKit

protocol CategoriesBuilderProtocol {
    static func build(navigationController: UINavigationController?) -> UIViewController
}

enum CategoriesRoute {
    case back
    case search(SearchRouteOption)
}

protocol CategoriesRouterProtocol {
    func navigate(to route: CategoriesRoute)
}

enum CategoriesCollectionViewTag: Int {
    case categories = 1
    case subCategories = 2
}

protocol CategoriesViewModelProtocol {
    
    // MARK: Dependency Properties
    var delegate: CategoriesViewProtocol? { get set }
    
    // MARK: Lifecycle Methods
    
    func viewDidLoad()
    func viewWillAppear()
    func viewDidLayoutSubviews()
    func viewDidAppear()
    func viewDidDisappear()
        
    // MARK: Actions
    func didTapCancelButton()
    func didTapSearchButton()
    
    // MARK: Data Source Methods
    func numberOfItems(in type: CategoriesCollectionViewTag) -> Int
    func cellForItem(in type: CategoriesCollectionViewTag, at indexPath: IndexPath) -> Any?
    func didSelectItem(in type: CategoriesCollectionViewTag, at indexPath: IndexPath)
    
}


protocol CategoriesViewProtocol: AnyObject {
    
    // MARK: Methods
    
    func prepareNavigationBar()
    func prepareUI()
    func prepareConstraints()
    func prepareCategoriesCollectionView()
    func prepareSubCategoriesCollectionView()
    func addSwipeGesture()
    func removeSwipeGesture()
    
    func reloadData(type: CategoriesCollectionViewTag)
    func reloadItems(type: CategoriesCollectionViewTag, at indexPaths: [IndexPath])
    
}
