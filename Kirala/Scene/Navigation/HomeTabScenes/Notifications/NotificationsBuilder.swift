//
//  NotificationsBuilder.swift
//  Kirala
//
//  Created by Ali Çolak on 17.05.2024.
//

import UIKit

final class NotificationsBuilder: NotificationsBuilderProtocol {
    
    static func build(navigationController: UINavigationController?) -> UIViewController {
        let router = NotificationsRouter(navigationController: navigationController)
        let dependencies = app.resolveDependencyArray(dependencies: [.authService])
        let viewModel = NotificationsViewModel(router: router, dependencies: dependencies)
        let viewController = NotificationsViewController(viewModel: viewModel)
        return viewController
    }
    
}
