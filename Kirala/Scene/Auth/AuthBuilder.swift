//
//  AuthBuilder.swift
//  Kirala
//
//  Created by Ali Çolak on 24.05.2024.
//

import UIKit

final class AuthBuilder: AuthBuilderProtocol {
    
    static func build(rootNavigationController: UINavigationController?, navigationController: UINavigationController?) -> UIViewController {
        let router = AuthRouter(rootNavigationController: rootNavigationController, navigationController: navigationController)
        let viewModel = AuthViewModel(router: router, authService: app.authService, authenticationService: app.authenticationService)
        let viewController = AuthViewController(viewModel: viewModel)
        return viewController
    }
    
}
