//
//  AdsTabBuilder.swift
//  Kirala
//
//  Created by Ali Çolak on 6.06.2024.
//

import UIKit

final class AdsTabBuilder: NavigationBuilderProtocol {
    
    static func build(arguments: TabBarItemArguments) -> UINavigationController {
        let navigationController = UINavigationController()
        let router = AdsRouter(navigationController: navigationController)
        let dependencies = app.resolveDependencyArray(dependencies: [.authService, .productService])
        let viewModel = AdsViewModel(router: router, dependencies: dependencies)
        let viewController = AdsViewController(viewModel: viewModel)
        viewController.tabBarItem = UITabBarItem(title: arguments.title, image: arguments.image.symbol(), tag: arguments.tag)
        navigationController.viewControllers = [viewController]
        return navigationController
    }
    
}
