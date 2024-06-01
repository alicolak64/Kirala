//
//  SplashRouter.swift
//  Kirala
//
//  Created by Ali Çolak on 13.05.2024.
//

import UIKit

final class SplashRouter: SplashRouterProtocol {

    func route(to route: SplashRoute) {
        switch route {
        case .tabbar:
            app.router.startTabBar()
        }
    }
    
}
