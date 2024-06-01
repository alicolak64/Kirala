//
//  AuthBuilder.swift
//  Kirala
//
//  Created by Ali Çolak on 24.05.2024.
//

import UIKit

final class AuthBuilder: AuthBuilderProtocol {
    
    static func build(navigationController: UINavigationController?) -> UIViewController {
        let router = AuthRouter(navigationController: navigationController)
        let viewModel = AuthViewModel(router: router)
        let viewController = AuthViewController(viewModel: viewModel)
        return viewController
    }
    
}
