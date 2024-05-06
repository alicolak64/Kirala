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
        app.router.start() // Start the app
        
        #if DEBUG
        DispatchQueue.global().async {
            // Arka planda yapılacak işlemler
            NFX.sharedInstance().start()
        }
        #endif
        
        return true
    }

    
}

