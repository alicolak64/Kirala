//
//  AppContainer.swift
//  Kirala
//
//  Created by Ali Çolak on 4.05.2024.
//

import UIKit

enum DependencyType {
    case authService
    case authenticationService
    case categoryService
    case productService
}

// MARK: - App Container Instance
let app = AppContainer()

final class AppContainer {
    
    // MARK: - Properties
    
    private let window: UIWindow
    
    private lazy var router: AppRouter = {
        AppRouter(window: window, dependencies: resolveDependencyArray(dependencies: [.authService]))
    }()
    
    private lazy var authService: AuthService = {
        AuthManager(keychainService: KeychainManager())
    }()
    
    private lazy var authenticationService: AuthenticationService = {
        AuthenticationManager()
    }()
    
    private lazy var categoryService: CategoryService = {
        CategoryManager()
    }()
    
    private lazy var productService: ProductService = {
        ProductManager()
    }()
        
    // MARK: - Initializers
    
    init() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
    }
    
    // MARK: - Dependency Injection
        
    func resolve(dependency: DependencyType) -> Any {
        switch dependency {
        case .authService:
            return authService
        case .authenticationService:
            return authenticationService
        case .categoryService:
            return categoryService
        }
    }
    
    func resolveDependencyArray(dependencies: [DependencyType]) -> [DependencyType : Any] {
        var resolvedDependencies: [DependencyType : Any] = [:]
        for dependency in dependencies {
            switch dependency {
            case .authService:
                resolvedDependencies[.authService] = authService
            case .authenticationService:
                resolvedDependencies[.authenticationService] = authenticationService
            case .categoryService:
                resolvedDependencies[.categoryService] = categoryService
            }
        }
        return resolvedDependencies
    }
    
    // MARK: - Navigation
    
    func start() {
        router.start()
    }
    
    func startTabBar() {
        router.startTabBar()
    }
    
    func handleDeepLink(with url: URL) -> Bool {
        return router.handleDeepLink(url: url)
    }
    
    
    
}

