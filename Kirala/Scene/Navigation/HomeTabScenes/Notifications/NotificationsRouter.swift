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
        case .login:
            let loginViewController = AuthBuilder.build(navigationController: navigationController)
            let loginNavController = UINavigationController(rootViewController: loginViewController)
            loginNavController.modalPresentationStyle = .fullScreen
            navigationController?.present(loginNavController, animated: true, completion: nil)
        }
    }
    
}
