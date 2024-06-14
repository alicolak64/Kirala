//
//  FavoritesTabBuilder.swift
//  Kirala
//
//  Created by Ali Çolak on 14.06.2024.
//

import UIKit

final class FavoritesTabBuilder: NavigationBuilderProtocol {
    
    static func build(arguments: TabBarItemArguments) -> UINavigationController {
        let navigationController = UINavigationController()
        let router = FavoritesRouter(navigationController: navigationController)
        let dependencies = app.resolveDependencyArray(dependencies: [.authService, .favoriteService])
        let viewModel = FavoritesViewModel(router: router, dependencies: dependencies)
        let viewController = FavoritesViewController(viewModel: viewModel)
        viewController.tabBarItem = UITabBarItem(title: arguments.title, image: arguments.image.symbol(), tag: arguments.tag)
        navigationController.viewControllers = [viewController]
        return navigationController
    }
    
}
