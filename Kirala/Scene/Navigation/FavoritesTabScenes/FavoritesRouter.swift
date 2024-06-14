//
//  FavoritesRouter.swift
//  Kirala
//
//  Created by Ali Çolak on 14.06.2024.
//

import UIKit

final class FavoritesRouter: FavoritesRouterProtocol {
    
    // MARK: - Properties
    private weak var navigationController: UINavigationController?
    
    // MARK: - Initializers
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func navigate(to route: FavoritesRoute) {
        switch route {
        case .detail(_):
            let detailNavController = UINavigationController()
            let detailViewController = DetailBuilder.build(rootNavigationController: navigationController, navigationController: detailNavController, arguments: DetailArguments(id: "1"))
            detailNavController.viewControllers = [detailViewController]
            detailNavController.modalPresentationStyle = .fullScreen
            navigationController?.present(detailNavController, animated: true, completion: nil)
        case .auth:
            let authNavController = UINavigationController()
            let authViewController = AuthBuilder.build(rootViewController: navigationController, navigationController: authNavController)
            authNavController.viewControllers = [authViewController]
            authNavController.modalPresentationStyle = .fullScreen
            navigationController?.present(authNavController, animated: true, completion: nil)
        case .home:
            navigationController?.tabBarController?.selectedIndex = TabBarItem.home.rawValue
        }
    }
    
}
