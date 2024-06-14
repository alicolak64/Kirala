//
//  TabBarContracts.swift
//  Kirala
//
//  Created by Ali Çolak on 6.05.2024.
//

import UIKit

/// Protocol for building the Tab Bar Controller.
protocol TabBarBuilderProtocol {
    /// Builds and returns the Tab Bar Controller.
    /// - Parameter item: The initial Tab Bar item.
    /// - Returns: A configured UITabBarController instance.
    static func build(with item: TabBarItem) -> UITabBarController
}

/// Protocol for building Navigation Controllers with specific arguments.
protocol NavigationBuilderProtocol {
    /// Builds and returns the Navigation Controller.
    /// - Parameter arguments: Arguments for configuring the tab bar item.
    /// - Returns: A configured UINavigationController instance.
    static func build(arguments: TabBarItemArguments) -> UINavigationController
}

/// Enum representing the different items in the Tab Bar.
enum TabBarItem: Int, CaseIterable {
    case home
    case favorites
    case myAds
    case myOrders
    case profile
}

/// Protocol for the Tab Bar View Model.
protocol TabBarViewModelProtocol {
    /// The delegate for the Tab Bar View.
    var delegate: TabBarViewProtocol? { get set }
    
    /// Called when the view is loaded.
    func viewDidLoad()
}

/// Structure representing the arguments for configuring a tab bar item.
struct TabBarItemArguments {
    var title: String
    var image: Symbolable
    var badge: Int?
    var tag: Int
}

/// Protocol for the Tab Bar View.
protocol TabBarViewProtocol: AnyObject {
    /// Prepares the UI for the Tab Bar.
    func prepareUI()
    
    /// Configures the view controllers for the Tab Bar.
    /// - Parameter viewControllers: An array of configured UINavigationController instances.
    func configureViewControllers(viewControllers: [UINavigationController])
    
    /// Configures the initial tab bar index.
    /// - Parameter index: The index to set as the initial selected tab.
    func configureInitialTabBar(with item: TabBarItem)
}
