//
//  NotificationsRouter.swift
//  Kirala
//
//  Created by Ali Çolak on 17.05.2024.
//

import UIKit

final class NotificationsRouter: NotificationsRouterProtocol {
    
    // MARK: - Properties
    private weak var navigationController: UINavigationController?
    
    // MARK: - Initializers
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func navigate(to route: NotificationsRoute) {
        switch route {
        case .back:
            navigationController?.popViewController(animated: true)
        case .auth:
            let authNavController = UINavigationController()
            let authViewController = AuthBuilder.build(rootNavigationController: navigationController, navigationController: authNavController)
            authNavController.viewControllers = [authViewController]
            authNavController.modalPresentationStyle = .fullScreen
            navigationController?.present(authNavController, animated: true, completion: nil)
        }
    }
    
}
