//
//  HomeTabBuilder.swift
//  Kirala
//
//  Created by Ali Çolak on 17.05.2024.
//

import UIKit

final class HomeTabBuilder: NavigationBuilderProtocol {
    
    static func build(arguments: TabBarItemArguments) -> UINavigationController {
        let navigationController = UINavigationController()
        let router = HomeRouter(navigationController: navigationController)
        let dependencies = app.resolveDependencyArray(dependencies: [.authService, .categoryService, .productService, .favoriteService])
        let viewModel = HomeViewModel(router: router, dependencies: dependencies)
        let viewController = HomeViewController(viewModel: viewModel, layoutGenerator: HomeCollectionViewLayoutsGenerator())
        viewController.tabBarItem = UITabBarItem(title: arguments.title, image: arguments.image.symbol(), tag: arguments.tag)
        navigationController.viewControllers = [viewController]
        return navigationController
    }
    
}
