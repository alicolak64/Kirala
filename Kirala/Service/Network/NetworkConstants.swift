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
        //return "http://localhost:8080"
        return "http://192.168.1.26:8080"
        //return "https://kirala-dev.onrender.com"
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
            static let forgotPassword = "/auth/send-reset-password-token"
            static let resetPassword = "/auth/reset-password"
        }
        
        enum Category {
            static let getCategories = "/categories"
            static let getSubcategories = "/subcategories/category/"
            static let getBrands = "/brands"
            static let getCities = "/cities"
        }
        
        enum Product {
            static let createProduct = "/products"
        }
    }
    
}
