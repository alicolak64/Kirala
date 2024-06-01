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
        let viewModel = CategoriesViewModel(router: router)
        let viewController = CategoriesViewController(viewModel: viewModel)
        return viewController
    }
    
}
