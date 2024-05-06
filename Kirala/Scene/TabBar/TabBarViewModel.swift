//
//  TabBarViewModel.swift
//  Kirala
//
//  Created by Ali Çolak on 6.05.2024.
//

import UIKit

final class TabBarViewModel: TabBarViewModelProtocol {
    
    weak var delegate: TabBarViewProtocol?
    
    private var items = [TabBarItemArguments]()
    
    private var controllers = [UINavigationController]()
    
    func viewDidLoad() {
        
        setTabBarItems()
        setCurrentTabBarItems()
        
        delegate?.prepareUI()
        delegate?.configureViewControllers(viewControllers: controllers)
        delegate?.configureInitialTabBar(index: 0)
        
    }
    
    func setTabBarItems() {
        
        TabBarItems.allCases.forEach { item in
            
            switch item {
            case .home:
                items.append(TabBarItemArguments(title: Localization.tabBar.localizedString(for: "HOME"), image: "house.fill", badge: nil, tag: 0))
            case .myAds:
                items.append(TabBarItemArguments(title: Localization.tabBar.localizedString(for: "MY_ADS"), image: "newspaper.fill", badge: nil, tag: 1))
            case .myOrders:
                items.append(TabBarItemArguments(title: Localization.tabBar.localizedString(for: "MY_ORDERS"), image: "shippingbox.fill", badge: nil, tag: 2))
            case .basket:
                items.append(TabBarItemArguments(title: Localization.tabBar.localizedString(for: "BASKET"), image: "cart.fill", badge: nil, tag: 3))
            case .profile:
                items.append(TabBarItemArguments(title: Localization.tabBar.localizedString(for: "PROFILE"), image: "person.fill", badge: nil, tag: 4))
            }
            
        }
        
    }
    
    func setCurrentTabBarItems() {
        
        TabBarItems.allCases.forEach { item in
            
            switch item {
            case .home:
                controllers.append(HomeNavigationBuilder.build(arguments: items[0]))
            case .myAds:
                controllers.append(MyAdsNavigationBuilder.build(arguments: items[1]))
            case .myOrders:
                controllers.append(MyOrdersNavigationBuilder.build(arguments: items[2]))
            case .basket:
                controllers.append(BasketNavigationBuilder.build(arguments: items[3]))
            case .profile:
                controllers.append(ProfileNavigationBuilder.build(arguments: items[4]))
                
            }
            
        }
        
    }
    
    
}
