//
//  AuthService.swift
//  Kirala
//
//  Created by Ali Çolak on 24.05.2024.
//

import Foundation


protocol AuthService {
    func getAuthToken() -> String?
    func saveAuthToken(token: String)
    func removeAuthToken()
    var isLoggedIn: Bool { get }
}

final class AuthManager: AuthService {
    
    private let keychainService: KeychainService
    
    init(keychainService: KeychainService) {
        self.keychainService = keychainService
    }
    
    func getAuthToken() -> String? {
        return keychainService.getString(key: .authToken)
    }
    
    func saveAuthToken(token: String) {
        keychainService.saveString(value: token, key: .authToken)
    }
    
    func removeAuthToken() {
        keychainService.removeString(key: .authToken)
    }
    
    var isLoggedIn: Bool {
        return keychainService.contains(key: .authToken)
    }
    
}
