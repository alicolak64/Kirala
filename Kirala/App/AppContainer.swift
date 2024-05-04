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
    
    let router = AppRouter()
    let navigationController = UINavigationController()
    
}
