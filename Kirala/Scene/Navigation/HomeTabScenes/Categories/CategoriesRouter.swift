//
//  CategoriesRouter.swift
//  Kirala
//
//  Created by Ali Çolak on 21.05.2024.
//

import UIKit


final class CategoriesRouter: CategoriesRouterProtocol {
    
    // MARK: - Properties
    private weak var navigationController: UINavigationController?
    
    // MARK: - Initializers
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func navigate(to route: CategoriesRoute) {
        switch route {
        case .search(let option):
            let animated = SearchRouteOption.isCategorySearch(option) || SearchRouteOption.isHeaderSearch(option)
            let searchViewController = SearchBuilder.build(navigationController: navigationController, searchOption: option)
            navigationController?.pushViewController(searchViewController, animated: animated)
        case .back:
            navigationController?.popViewController(animated: true)
        }
    }
    
}
