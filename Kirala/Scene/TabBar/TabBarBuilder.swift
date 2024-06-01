//
//  TabBarBuilder.swift
//  Kirala
//
//  Created by Ali Çolak on 6.05.2024.
//

import UIKit

final class TabBarBuilder: TabBarBuilderProtocol {
    
    static func build(with item: TabBarItem = .home) -> UITabBarController {
        let viewModel = TabBarViewModel(initalItem: item)
        let tabBarController = TabBarController(viewModel: viewModel)
        return tabBarController
    }
    
}
