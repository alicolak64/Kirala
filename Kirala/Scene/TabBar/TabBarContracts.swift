//
//  TabBarContracts.swift
//  Kirala
//
//  Created by Ali Çolak on 6.05.2024.
//

import UIKit

protocol TabBarBuilderProtocol {
    static func build() -> UITabBarController
}

protocol NavigationBuilderProtocol {
    static func build(arguments: TabBarItemArguments) -> UINavigationController
}

enum TabBarItems: CaseIterable {
    case home
    case myAds
    case myOrders
    case basket
    case profile
}

protocol TabBarViewModelProtocol {
    
    var delegate: TabBarViewProtocol? { get set }
    
    func viewDidLoad()
}

struct TabBarItemArguments {
    var title : String
    var image : Symbolable
    var badge : Int?
    var tag : Int
}

protocol TabBarViewProtocol: AnyObject {
    func prepareUI()
    func configureViewControllers(viewControllers: [UINavigationController])
    func configureInitialTabBar(index: Int)
}


