//
//  TabBarViewModel.swift
//  Kirala
//
//  Created by Ali Çolak on 6.05.2024.
//

import UIKit

final class TabBarViewModel: TabBarViewModelProtocol {
    
    // MARK: - Properties
    
    weak var delegate: TabBarViewProtocol?
    
    private var items = [TabBarItemArguments]()
    private var controllers = [UINavigationController]()
    private var initalTabBarItem: TabBarItem
    
    init(initalItem: TabBarItem = .home) {
        self.initalTabBarItem = initalItem
    }
    
    // MARK: - Methods
    
    /// Called when the view is loaded.
    func viewDidLoad() {
        setTabBarItems()
        setCurrentTabBarItems()
        
        delegate?.prepareUI()
        delegate?.configureViewControllers(viewControllers: controllers)
        delegate?.configureInitialTabBar(with: initalTabBarItem)
    }
    
    /// Sets the tab bar items with their respective properties.
    private func setTabBarItems() {
        TabBarItem.allCases.forEach { item in
            switch item {
            case .home:
                items.append(
                    TabBarItemArguments(
                        title: Strings.TabBar.home.localized,
                        image: Symbols.houseFill,
                        badge: nil,
                        tag: 0
                    )
                )
            case .myAds:
                items.append(
                    TabBarItemArguments(
                        title: Strings.TabBar.myAds.localized,
                        image: Symbols.newspaperFill,
                        badge: nil,
                        tag: 1
                    )
                )
            case .myOrders:
                items.append(
                    TabBarItemArguments(
                        title: Strings.TabBar.myOrders.localized,
                        image: Symbols.shippingboxFill,
                        badge: nil,
                        tag: 2
                    )
                )
            case .cart:
                items.append(
                    TabBarItemArguments(
                        title: Strings.TabBar.cart.localized,
                        image: Symbols.cartFill,
                        badge: 0,
                        tag: 3
                    )
                )
            case .profile:
                items.append(
                    TabBarItemArguments(
                        title: Strings.TabBar.profile.localized,
                        image: Symbols.personFill,
                        badge: nil,
                        tag: 4
                    )
                )
            }
        }
    }
    
    /// Sets the current tab bar items with their respective navigation controllers.
    private func setCurrentTabBarItems() {
        controllers = TabBarItem.allCases.map { item in
            switch item {
            case .home:
                return HomeTabBuilder.build(arguments: items[0])
            case .myAds:
                return AdsTabBuilder.build(arguments: items[1])
            case .myOrders:
                return MyOrdersNavigationBuilder.build(arguments: items[2])
            case .cart:
                return CartNavigationBuilder.build(arguments: items[3])
            case .profile:
                return ProfileNavigationBuilder.build(arguments: items[4])
            }
        }
    }
}
