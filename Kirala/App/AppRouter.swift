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
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
    }
    
    // MARK: - Start
    
    func start() {
        checkOnboarding()
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
