//
//  AddAdBuilder.swift
//  Kirala
//
//  Created by Ali Çolak on 6.06.2024.
//

import UIKit

final class AddAdBuilder: AddAdBuilderProtocol {
    
    
    static func build(rootNavigationController: UINavigationController?, navigationController: UINavigationController?) -> UIViewController {
        let router = AddAdRouter(rootNavigationController: rootNavigationController, navigationController: navigationController)
        let viewModel = AddAdViewModel(router: router, authService: app.authService)
        let viewController = AddAdViewController(viewModel: viewModel)
        return viewController
    }
    
    static func build(rootNavigationController: UINavigationController?, navigationController: UINavigationController?, arguments: EditAddAdArguments) -> UIViewController {
        let router = AddAdRouter(rootNavigationController: rootNavigationController, navigationController: navigationController)
        let viewModel = AddAdViewModel(router: router, arguments: arguments, authService: app.authService)
        let viewController = AddAdViewController(viewModel: viewModel)
        return viewController
    }
    
}
