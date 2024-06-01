//
//  Constants.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

enum NetworkConstants {
    static var baseUrl: String {
    #if DEBUG
        return "http://192.168.1.61:8080"
    #else
        return "https://example.com/api"
    #endif
    }
    
    enum Endpoints {
        enum Auth {
            static let loginWithGoogle = "oauth2/authorize/google"
            static let login = "/auth/login"
            static let register = "/auth/register"
            static let logout = "/auth/logout"
            static let resetPassword = "/auth/reset-password"
        }
    }
    
}
