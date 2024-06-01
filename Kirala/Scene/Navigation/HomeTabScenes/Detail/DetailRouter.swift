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
        case .login:
            let loginViewController = AuthBuilder.build(navigationController: navigationController)
            let loginNavController = UINavigationController(rootViewController: loginViewController)
            loginNavController.modalPresentationStyle = .fullScreen
            navigationController?.present(loginNavController, animated: true, completion: nil)
        }
    }
    
}
