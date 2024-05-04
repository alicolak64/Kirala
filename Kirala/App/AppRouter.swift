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
        
        window.rootViewController = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()
        window.makeKeyAndVisible()
        
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) { [weak self] in // Wait 1 seconds for launch screen
//            guard let self = self else { return }
//            self.checkOnboarding()
//        }
        
        checkOnboarding()
        
    }
    
    func checkOnboarding() {
//        if app.stroageService.isOnBoardingSeen() {
//            startHome()
//        } else {
//            startOnboarding()
//        }
        startHome()
    }
    
    func startOnboarding() {
//        window.rootViewController = OnboardingBuilder().build()
    }
    
    func startHome() {
//        let homeViewController = HomeBuilder().build()
//        let navigationController = app.navigationController
//        navigationController.viewControllers = [homeViewController]
//        window.rootViewController = navigationController
        let viewController = ViewController()
        let navigationController = app.navigationController
        navigationController.viewControllers = [viewController]
        window.rootViewController = navigationController
    }
    
}
