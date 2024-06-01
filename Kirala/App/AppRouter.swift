//
//  AppRouter.swift
//  Kirala
//
//  Created by Ali Çolak on 4.05.2024.
//

import UIKit

final class AppRouter {
    
    // MARK: - Properties
    
    let window: UIWindow
    
    // MARK: - Initializers
    
    init(window: UIWindow = UIWindow(frame: UIScreen.main.bounds)) {
        self.window = window
    }
    
    // MARK: - Start
    
    func start() {
        checkOnboarding()
    }
    
    func handleDeepLink(url: URL) -> Bool {
        guard let scheme = url.scheme, scheme == "kiralaapp",
              let host = url.host else {
            return false
        }
        
        let pathComponents = url.pathComponents.filter { $0 != "/" }
        
        switch host {
        case "home":
            navigateToHome()
        case "profile":
            navigateToProfile(userId: pathComponents.first)
        case "product":
            if let productId = pathComponents.first {
                navigateToProduct(productId: productId)
            }
        default:
            return false
        }
        
        return true
    }
    
    private func navigateToHome() {
        let tabBarController = TabBarBuilder.build(with: .home)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }

    private func navigateToProfile(userId: String?) {
        let tabBarController = TabBarBuilder.build(with: .profile)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }

    private func navigateToProduct(productId: String) {
        print("Product ID: \(productId)")
    }
    
    func checkOnboarding() {
        //        if app.stroageService.isOnBoardingSeen() {
        //            startHome()
        //        } else {
        //            startOnboarding()
        //        }
        startSplash()
    }
    
    func startOnboarding() {
        //        window.rootViewController = OnboardingBuilder().build()
    }
    
    func startSplash() {
        let splashViewController = SplashBuilder.build()
        window.rootViewController = splashViewController
        window.makeKeyAndVisible()
    }
    
    func startTabBar() {
        //        let homeViewController = HomeBuilder().build()
        //        let navigationController = app.navigationController
        //        navigationController.viewControllers = [homeViewController]
        //        window.rootViewController = navigationController
        let tabBarController = TabBarBuilder.build()
        window.rootViewController = tabBarController
    }
    
}
