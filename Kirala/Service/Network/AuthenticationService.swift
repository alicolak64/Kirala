//
//  UserService.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

protocol AuthenticationService {
    func login(email: String, password: String, completion: @escaping (Result<NoData, ErrorResponse>) -> Void)
    func loginWithGoogle() -> URL?
    func register(email: String, password: String, completion: @escaping (Result<NoData, ErrorResponse>) -> Void)
    func logout(completion: @escaping (Result<NoData, ErrorResponse>) -> Void)
    func resetPassword(email: String, completion: @escaping (Result<NoData, ErrorResponse>) -> Void)
}

final class AuthenticationManager: AuthenticationService {
    
    func login(email: String, password: String, completion: @escaping (Result<NoData, ErrorResponse>) -> Void) {
        
        let request = AuthRequest(email: email, password: password)
        
        let provider = ApiServiceProvider<AuthRequest>(method: .post, baseUrl: NetworkConstants.baseUrl, path: NetworkConstants.Endpoints.Auth.login, data: request)
                
        try? APIManager.shared.executeRequest(urlRequest: provider.returnUrlRequest(), completion: completion)
    }
    
    func loginWithGoogle() -> URL? {
        let parameters: [String:String] = ["redirect_uri": "kiralaapp://oauth2"]
        let provider = ApiServiceProvider< [String:String]>(method: .get, baseUrl: NetworkConstants.baseUrl, path: NetworkConstants.Endpoints.Auth.loginWithGoogle, data: parameters)
        return try? provider.returnUrlRequest().url
    }
    
    func register(email: String, password: String, completion: @escaping (Result<NoData, ErrorResponse>) -> Void) {
        return
    }
    
    func logout(completion: @escaping (Result<NoData, ErrorResponse>) -> Void) {
        return
    }
    
    func resetPassword(email: String, completion: @escaping (Result<NoData, ErrorResponse>) -> Void) {
        return
    }
    
}
