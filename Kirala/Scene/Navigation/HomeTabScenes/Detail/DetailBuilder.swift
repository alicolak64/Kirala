//
//  DetailBuiler.swift
//  Kirala
//
//  Created by Ali Çolak on 21.05.2024.
//

import UIKit

final class DetailBuilder: DetailBuilderProtocol {
    
    static func build(rootNavigationController: UINavigationController?, navigationController: UINavigationController?, arguments: DetailArguments) -> UIViewController {
        let router = DetailRouter(rootNavigationController: rootNavigationController, navigationController: navigationController)
        let dependencies = app.resolveDependencyArray(dependencies: [.authService, .productService, .favoriteService])
        let viewModel = DetailViewModel(router: router, dependencies: dependencies, arguments: arguments)
        let viewController = DetailViewController(viewModel: viewModel)
        return viewController
    }
    
}
