//
//  TabBarBuilder.swift
//  Kirala
//
//  Created by Ali Çolak on 6.05.2024.
//

import UIKit

final class TabBarBuilder: TabBarBuilderProtocol {
    
    // MARK: - Methods
    
    static func build() -> UITabBarController {
        let viewModel = TabBarViewModel()
        let tabBarController = TabBarController(viewModel: viewModel)
        return tabBarController
    }
    
}
