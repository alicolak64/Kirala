//
//  AdsRouter.swift
//  Kirala
//
//  Created by Ali Çolak on 6.06.2024.
//


import UIKit

final class AdsRouter: AdsRouterProtocol {
    
    // MARK: - Properties
    private weak var navigationController: UINavigationController?
    
    // MARK: - Initializers
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func navigate(to route: AdsRoute) {
        switch route {
        case .auth:
            let authNavController = UINavigationController()
            let authViewController = AuthBuilder.build(rootViewController: navigationController, navigationController: authNavController)
            authNavController.viewControllers = [authViewController]
            authNavController.modalPresentationStyle = .fullScreen
            navigationController?.present(authNavController, animated: true, completion: nil)
        case .add(let option):
            let addNavController = UINavigationController()
            switch option {
            case .addAd:
                let addAdViewController = AddAdBuilder.build(rootNavigationController: navigationController, navigationController: addNavController)
                addNavController.viewControllers = [addAdViewController]
                addNavController.modalPresentationStyle = .fullScreen
                navigationController?.present(addNavController, animated: true, completion: nil)
            case .editAd(let arguments):
                let addAdViewController = AddAdBuilder.build(rootNavigationController: navigationController, navigationController: addNavController, arguments: arguments)
                addNavController.viewControllers = [addAdViewController]
                addNavController.modalPresentationStyle = .fullScreen
                navigationController?.present(addNavController, animated: true, completion: nil)
            }
        }
    }
    
}

