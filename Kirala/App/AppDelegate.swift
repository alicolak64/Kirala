//
//  AppDelegate.swift
//  Kirala
//
//  Created by Ali Çolak on 4.05.2024.
//

import UIKit
import netfox


@main

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        app.start()// Start the app
        
        #if DEBUG
        DispatchQueue.global().async {
            // Background tasks
            NFX.sharedInstance().start()
        }
        #endif
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        #if DEBUG
        NFX.sharedInstance().stop()
        #endif
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        #if DEBUG
        NFX.sharedInstance().stop()
        #endif
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        #if DEBUG
        NFX.sharedInstance().start()
        #endif
    }
    
    // Handle incoming URLs for iOS 13 and later
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return app.handleDeepLink(with: url)
    }
    
    // Handle incoming URLs for iOS 12 and earlier
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return app.handleDeepLink(with: url)
    }
    
}

