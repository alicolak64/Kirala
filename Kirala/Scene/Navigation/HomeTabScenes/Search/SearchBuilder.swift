//
//  SearchBuilder.swift
//  Kirala
//
//  Created by Ali Çolak on 17.05.2024.
//

import UIKit

final class SearchBuilder: SearchBuilderProtocol {
    
    static func build(navigationController: UINavigationController?, searchOption: SearchRouteOption) -> UIViewController {
        let router = SearchRouter(navigationController: navigationController)
        let filterRouter = FilterRouter(rootNavigationController: navigationController)
        let viewModel = SearchViewModel(router: router, searchOption: searchOption, authService: app.authService, filterRouter: filterRouter)
        let viewController = SearchViewController(viewModel: viewModel)
        return viewController
    }
    
}
