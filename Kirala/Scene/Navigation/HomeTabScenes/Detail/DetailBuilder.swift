//
//  DetailBuiler.swift
//  Kirala
//
//  Created by Ali Çolak on 21.05.2024.
//

import UIKit

final class DetailBuilder: DetailBuilderProtocol {
    
    static func build(rootNavigationController: UINavigationController?, navigationController: UINavigationController?) -> UIViewController {
        let router = DetailRouter(rootNavigationController: rootNavigationController, navigationController: navigationController)
        let dependencies = app.resolveDependencyArray(dependencies: [.authService])
        let viewModel = DetailViewModel(router: router, dependencies: dependencies)
        let viewController = DetailViewController(viewModel: viewModel)
        return viewController
    }
    
}
