//
//  AppDelegate.swift
//  Kirala
//
//  Created by Ali Çolak on 4.05.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        app.router.start() // Start the app
        return true
    }

    
}

