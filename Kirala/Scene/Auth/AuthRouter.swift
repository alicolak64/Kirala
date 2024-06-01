//
//  AuthRouter.swift
//  Kirala
//
//  Created by Ali Çolak on 24.05.2024.
//

import UIKit

final class AuthRouter: AuthRouterProtocol {
    
    // MARK: - Properties
    private weak var navigationController: UINavigationController?
    
    // MARK: - Initializers
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func navigate(to route: AuthRoute) {
        switch route {
        case .back:
            navigationController?.dismiss(animated: true)
        }
    }
    
}
