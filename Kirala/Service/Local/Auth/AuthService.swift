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
    func saveAuthTokenType(tokenType: String)
    func saveResetPasswordToken(token: String)
    func saveError(error: String)
    func getResetPasswordToken() -> String?
    func getError() -> String?
    func removeAuthToken()
    func removeResetPasswordToken()
    func removeError()
    var isLoggedIn: Bool { get }
    var isResetPasswordTokenAvailable: Bool { get }
    var isErrorAvailable: Bool { get }
}

final class AuthManager: AuthService {
    
    private let keychainService: KeychainService
    
    init(keychainService: KeychainService) {
        self.keychainService = keychainService
    }
    
    func getAuthToken() -> String? {
        guard let tokenType = keychainService.getString(key: .authTokenType),
              let token = keychainService.getString(key: .authToken) else {
            return nil
        }
        return "\(tokenType) \(token)"
    }
    
    func getResetPasswordToken() -> String? {
        return keychainService.getString(key: .resetPasswordToken)
    }
    
    func getError() -> String? {
        return keychainService.getString(key: .error)
    }
    
    func saveAuthToken(token: String) {
        keychainService.saveString(value: token, key: .authToken)
    }
    
    func saveAuthTokenType(tokenType: String) {
        keychainService.saveString(value: tokenType, key: .authTokenType)
    }
    
    func saveResetPasswordToken(token: String) {
        keychainService.saveString(value: token, key: .resetPasswordToken)
    }
    
    func saveError(error: String) {
        keychainService.saveString(value: error, key: .error)
    }
    
    func removeAuthToken() {
        keychainService.removeString(key: .authToken)
    }
    
    func removeResetPasswordToken() {
        keychainService.removeString(key: .resetPasswordToken)
    }
    
    func removeError() {
        keychainService.removeString(key: .error)
    }
    
    var isLoggedIn: Bool {
        return keychainService.contains(key: .authToken)
    }
    
    var isResetPasswordTokenAvailable: Bool {
        return keychainService.contains(key: .resetPasswordToken)
    }
    
    var isErrorAvailable: Bool {
        return keychainService.contains(key: .error)
    }
    
}
