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
    
    private func getToken(url: URL) -> String? {
        // URL'i işleyip yetkilendirme kodunu çekin
        if let components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            if let token = components.queryItems?.first(where: { $0.name == "token" })?.value {
                return token
            }
        }
        
        return nil
        
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
            navigateToProfile()
        case "product":
            if let productId = pathComponents.first {
                navigateToProduct(productId: productId)
            }
        case "oauth2":
            if let token = getToken(url: url) {
                app.authService.saveAuthToken(token: token)
                showLottieAnimation()
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

    private func navigateToProfile() {
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
    
    private func showLottieAnimation() {
        let lottieVC = LottieViewController(lottie: .loginSuccess) {
            self.navigateToProfile()
        }
        lottieVC.modalPresentationStyle = .fullScreen
        window.rootViewController?.present(lottieVC, animated: true, completion: nil)
    }
    
}
