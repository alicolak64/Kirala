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
        //return "http://192.168.1.26:8080"
        return "https://kirala-dev.onrender.com"
        //return "http://172.16.34.221:8080"
        //return "http://192.168.1.111:8080"
        //return "http://172.16.35.37:8080"
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
            static let resendVerificationEmail = "/auth/send-email-verification-token"
        }
        
        enum Category {
            static let getCategories = "/categories"
            static let getSubcategories = "/subcategories/category/"
            static let getBrands = "/brands"
            static let getCities = "/cities"
            static let getCampaigns = "/campaigns"
            static let getCategoryListWithSubcategories = "/categories/subcategories"
        }
        
        enum Product {
            static let createProduct = "/products"
            static let getProductsByUser = "/products/user"
            static let getProductById = "/products/"
            static let updateProduct = "/products"
            static let deleteProduct = "/products/"
            static let getProducts = "/products"
        }
        
        enum Favorite {
            static let getFavorites = "/favorites"
            static let toggleFavorite = "/favorites"
        }
        
    }
    
    enum Constraints {
        static let paginationSize = 10
        static let infinityScrollLateLimitSecond = 1.0
        static let infinityScrollPercentage = 0.9
    }
    
}
