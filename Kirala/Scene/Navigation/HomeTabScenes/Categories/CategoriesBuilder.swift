//
//  CategoriesBuilder.swift
//  Kirala
//
//  Created by Ali Çolak on 21.05.2024.
//

import UIKit

final class CategoriesBuilder: CategoriesBuilderProtocol {
    
    static func build(navigationController: UINavigationController?) -> UIViewController {
        let router = CategoriesRouter(navigationController: navigationController)
        let dependencies = app.resolveDependencyArray(dependencies: [.categoryService])
        let viewModel = CategoriesViewModel(router: router, dependencies: dependencies)
        let viewController = CategoriesViewController(viewModel: viewModel)
        return viewController
    }
    
}
