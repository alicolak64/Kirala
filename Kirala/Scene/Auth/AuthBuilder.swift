//
//  AuthBuilder.swift
//  Kirala
//
//  Created by Ali Çolak on 24.05.2024.
//

import UIKit

final class AuthBuilder: AuthBuilderProtocol {
    
    static func build(rootViewController: UIViewController?, navigationController: UINavigationController?) -> UIViewController {
        let router = AuthRouter(rootViewController: rootViewController, navigationController: navigationController)
        let dependencies = app.resolveDependencyArray(dependencies: [.authService, .authenticationService])
        let viewModel = AuthViewModel(router: router, dependencies: dependencies)
        let viewController = AuthViewController(viewModel: viewModel)
        return viewController
    }
    
}
