//
//  AddAdRouter.swift
//  Kirala
//
//  Created by Ali Çolak on 6.06.2024.
//

import UIKit

final class AddAdRouter: AddAdRouterProtocol {
    
    private weak var navigationController: UINavigationController?
    private var rootNavigationController: UINavigationController?
    
    init(rootNavigationController: UINavigationController?, navigationController: UINavigationController?) {
        self.rootNavigationController = rootNavigationController
        self.navigationController = navigationController
    }
    
    func navigate(to route: AddAdRoute) {
        switch route {
        case .back:
            rootNavigationController?.dismiss(animated: true)
        case .location(let viewModel):
            let selectLocationVC = SelectLocationViewController()
            selectLocationVC.delegate = viewModel
            navigationController?.pushViewController(selectLocationVC, animated: true)
        }
    }
    
}
