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
    
    private func getAuthToken(url: URL) -> (String, String)? {
        // URL'i işleyip yetkilendirme kodunu çekin
        if let components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            if let token = components.queryItems?.first(where: { $0.name == "accessToken" })?.value, let tokenType = components.queryItems?.first(where: { $0.name == "tokenType" })?.value {
                return (token, tokenType)
            }
        }
        return nil
    }
    
    private func getResetPasswordToken(url: URL) -> String? {
        if let components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            if let token = components.queryItems?.first(where: { $0.name == "token" })?.value {
                return token
            }
        }
        return nil
    }
    
    private func getError(url: URL) -> String? {
        if let components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            if let error = components.queryItems?.first(where: { $0.name == "error" })?.value {
                return error
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
        
        print("url", url)
        
        switch host {
        case "home":
            navigateToHome()
        case "profile":
            navigateToProfile(userId: "")
        case "product":
            if let productId = pathComponents.first {
                navigateToProduct(productId: productId)
            }
        case "oauth2":
            if let (token, tokenType) = getAuthToken(url: url) {
                app.authService.saveAuthToken(token: token)
                app.authService.saveAuthTokenType(tokenType: tokenType)
                navigateToProfileWithLoginSuccess()
            }
        case "login":
            let tabBarController = TabBarBuilder.build()
            let authNavController = UINavigationController()
            let authViewController = AuthBuilder.build(rootViewController: tabBarController, navigationController: authNavController)
            authNavController.viewControllers = [authViewController]
            authNavController.modalPresentationStyle = .fullScreen
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
            tabBarController.present(authNavController, animated: false, completion: nil)
        case "reset-password":
            if let token = getResetPasswordToken(url: url) {
                app.authService.saveResetPasswordToken(token: token)
                DispatchQueue.main.async { [weak self] in
                    let tabBarController = TabBarBuilder.build()
                    let authNavController = UINavigationController()
                    let authViewController = AuthBuilder.build(rootViewController: tabBarController, navigationController: authNavController)
                    authNavController.viewControllers = [authViewController]
                    authNavController.modalPresentationStyle = .fullScreen
                    self?.window.rootViewController = tabBarController
                    self?.window.makeKeyAndVisible()
                    tabBarController.present(authNavController, animated: false, completion: nil)
                }
            }
        case "reset-password-error":
            if let error = getError(url: url) {
                app.authService.saveError(error: error)
                DispatchQueue.main.async { [weak self] in
                    let tabBarController = TabBarBuilder.build()
                    let authNavController = UINavigationController()
                    let authViewController = AuthBuilder.build(rootViewController: tabBarController, navigationController: authNavController)
                    authNavController.viewControllers = [authViewController]
                    authNavController.modalPresentationStyle = .fullScreen
                    self?.window.rootViewController = tabBarController
                    self?.window.makeKeyAndVisible()
                    tabBarController.present(authNavController, animated: false, completion: nil)
                }
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
    
    private func navigateToProfileWithLoginSuccess() {
        let temporaryViewController = UIViewController()
        temporaryViewController.view.backgroundColor = .clear
        
        window.rootViewController = temporaryViewController
        window.makeKeyAndVisible()
        
        let lottieVC = LottieViewController(lottie: .loginSuccess) { [weak self] in
            let tabBarController = TabBarBuilder.build(with: .profile)
            self?.window.rootViewController = tabBarController
        }
        lottieVC.modalPresentationStyle = .fullScreen
        temporaryViewController.present(lottieVC, animated: true)
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
