//
//  DetailRouter.swift
//  Kirala
//
//  Created by Ali Çolak on 21.05.2024.
//

import UIKit

final class DetailRouter: DetailRouterProtocol {
    
    // MARK: - Properties
    private weak var rootNavigationController: UINavigationController?
    private weak var navigationController: UINavigationController?
    
    // MARK: - Initializers
    init(rootNavigationController: UINavigationController?, navigationController: UINavigationController?) {
        self.rootNavigationController = rootNavigationController
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func navigate(to route: DetailRoute) {
        switch route {
        case .back:
            rootNavigationController?.dismiss(animated: true)
        case .search(let option):
            let animated = SearchRouteOption.isCategorySearch(option) || SearchRouteOption.isHeaderSearch(option)
            let searchViewController = SearchBuilder.build(navigationController: navigationController, searchOption: option)
            navigationController?.pushViewController(searchViewController, animated: animated)
        case .cart:
            let cartViewController = CartViewController()
            navigationController?.pushViewController(cartViewController, animated: false)
            navigationController?.navigationBar.backIndicatorImage = Symbols.arrowLeft.symbol()
            navigationController?.navigationBar.backIndicatorTransitionMaskImage = Symbols.arrowLeft.symbol()
            navigationController?.navigationBar.tintColor = .black
            navigationController?.navigationBar.backItem?.title = ""
        case .auth:
            let authNavController = UINavigationController()
            let authViewController = AuthBuilder.build(rootViewController: navigationController, navigationController: authNavController)
            authNavController.viewControllers = [authViewController]
            authNavController.modalPresentationStyle = .fullScreen
            navigationController?.present(authNavController, animated: true, completion: nil)
        }
    }
    
}
