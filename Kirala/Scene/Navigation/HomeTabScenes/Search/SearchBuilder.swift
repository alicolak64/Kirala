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
        let dependencies = app.resolveDependencyArray(dependencies: [.authService])
        let viewModel = SearchViewModel(router: router, searchOption: searchOption, filterRouter: filterRouter, dependencies: dependencies)
        let viewController = SearchViewController(viewModel: viewModel)
        return viewController
    }
    
}
