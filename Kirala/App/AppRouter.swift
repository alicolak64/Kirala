//
//  AppRouter.swift
//  Kirala
//
//  Created by Ali Çolak on 4.05.2024.
//

import UIKit

enum DeepLink {
    case home
    case profile
    case product(productId: String)
    case oauth2(token: String, tokenType: String)
    case login
    case resetPassword(token: String)
    case resetPasswordError(error: String)
}

final class AppRouter {
    
    // MARK: - Properties
    
    let window: UIWindow
    let authService: AuthService
    
    // MARK: - Initializers
    
    init(window: UIWindow = UIWindow(frame: UIScreen.main.bounds), dependencies: [Dependency : Any]) {
        guard let authService = dependencies[.authService] as? AuthService else {
            fatalError("AuthService not found")
        }
        self.window = window
        self.authService = authService
    }
    
    // MARK: - Start
    
    func start() {
        checkOnboarding()
    }
    
    private func getAuthToken(url: URL) -> (String, String)? {
        if let components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            if let token = components.queryItems?.first(where: { $0.name == "accessToken" })?.value,
               let tokenType = components.queryItems?.first(where: { $0.name == "tokenType" })?.value {
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
        guard let deepLink = parseDeepLink(url: url) else {
            return false
        }
        
        navigateToDeepLink(deepLink)
        return true
    }
    
    private func parseDeepLink(url: URL) -> DeepLink? {
        guard let scheme = url.scheme, scheme == "kiralaapp",
              let host = url.host else {
            return nil
        }
        
        let pathComponents = url.pathComponents.filter { $0 != "/" }
        
        switch host {
        case "home":
            return .home
        case "profile":
            return .profile
        case "product":
            if let productId = pathComponents.first {
                return .product(productId: productId)
            }
        case "oauth2":
            if let (token, tokenType) = getAuthToken(url: url) {
                return .oauth2(token: token, tokenType: tokenType)
            }
        case "login":
            return .login
        case "reset-password":
            if let token = getResetPasswordToken(url: url) {
                return .resetPassword(token: token)
            }
        case "reset-password-error":
            if let error = getError(url: url) {
                return .resetPasswordError(error: error)
            }
        default:
            return nil
        }
        
        return nil
    }
    
    private func navigateToDeepLink(_ deepLink: DeepLink) {
        switch deepLink {
        case .home:
            navigateToHome()
        case .profile:
            navigateToProfile(userId: "")
        case .product(let productId):
            navigateToProduct(productId: productId)
        case .oauth2(let token, let tokenType):
            authService.saveAuthToken(token: token)
            authService.saveAuthTokenType(tokenType: tokenType)
            navigateToProfileWithLoginSuccess()
        case .login:
            let tabBarController = TabBarBuilder.build()
            let authNavController = UINavigationController()
            let authViewController = AuthBuilder.build(rootViewController: tabBarController, navigationController: authNavController)
            authNavController.viewControllers = [authViewController]
            authNavController.modalPresentationStyle = .fullScreen
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
            tabBarController.present(authNavController, animated: false, completion: nil)
        case .resetPassword(let token):
            authService.saveResetPasswordToken(token: token)
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
        case .resetPasswordError(let error):
            authService.saveError(error: error)
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
        startSplash()
    }
    
    func startOnboarding() {
        // window.rootViewController = OnboardingBuilder().build()
    }
    
    func startSplash() {
        let splashViewController = SplashBuilder.build()
        window.rootViewController = splashViewController
        window.makeKeyAndVisible()
    }
    
    func startTabBar() {
        let tabBarController = TabBarBuilder.build()
        window.rootViewController = tabBarController
    }
}

