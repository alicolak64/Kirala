//
//  AppContainer.swift
//  Kirala
//
//  Created by Ali Çolak on 4.05.2024.
//

import UIKit

// MARK: - App Container Instance
let app = AppContainer()

final class AppContainer {
    
    // MARK: - Properties
    
    let window: UIWindow
    
    lazy var router: AppRouter = {
        AppRouter(window: window)
    }()
    
    lazy var authService: AuthService = {
        AuthManager(keychainService: KeychainManager())
    }()
    
    lazy var authenticationService: AuthenticationService = {
        AuthenticationManager()
    }()
        
    // MARK: - Initializers
    
    init() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
    }
    
}
