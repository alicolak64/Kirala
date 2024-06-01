//
//  HomeRouter.swift
//  Kirala
//
//  Created by Ali Çolak on 17.05.2024.
//

import UIKit

final class HomeRouter: HomeRouterProtocol {
    
    // MARK: - Properties
    private weak var navigationController: UINavigationController?
    
    // MARK: - Initializers
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func navigate(to route: HomeRoute) {
        switch route {
        case .detail(_):
            let detailNavController = UINavigationController()
            let detailViewController = DetailBuilder.build(rootNavigationController: navigationController, navigationController: detailNavController)
            detailNavController.viewControllers = [detailViewController]
            detailNavController.modalPresentationStyle = .fullScreen
            navigationController?.present(detailNavController, animated: true, completion: nil)
        case .search(let searchOption):
            let animated = SearchRouteOption.isCategorySearch(searchOption) || SearchRouteOption.isHeaderSearch(searchOption)
            let searchViewController = SearchBuilder.build(navigationController: navigationController, searchOption: searchOption)
            navigationController?.pushViewController(searchViewController, animated: animated)
        case .notifications:
            let notificationsViewController = NotificationsBuilder.build(navigationController: navigationController )
            navigationController?.pushViewController(notificationsViewController, animated: true)
        case .categories:
            let categoriesViewController = CategoriesBuilder.build(navigationController: navigationController)
            navigationController?.pushViewController(categoriesViewController, animated: true)
        case .login:
            let loginViewController = AuthBuilder.build(navigationController: navigationController)
            let loginNavController = UINavigationController(rootViewController: loginViewController)
            loginNavController.modalPresentationStyle = .fullScreen
            navigationController?.present(loginNavController, animated: true, completion: nil)
        }
    }
    
}
