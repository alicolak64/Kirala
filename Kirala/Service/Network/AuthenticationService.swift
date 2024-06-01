//
//  UserService.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

protocol AuthenticationService {
    func login(username: String, password: String, completion: @escaping (Result<NoData, ErrorResponse>) -> Void)
    func loginWithGoogle() -> URL?
    func register(username: String, password: String, completion: @escaping (Result<NoData, ErrorResponse>) -> Void)
    func logout(completion: @escaping (Result<NoData, ErrorResponse>) -> Void)
    func resetPassword(username: String, completion: @escaping (Result<NoData, ErrorResponse>) -> Void)
}

final class AuthenticationManager: AuthenticationService {
    
    func login(username: String, password: String, completion: @escaping (Result<NoData, ErrorResponse>) -> Void) {
//        let serviceProvider = ApiServiceProvider<NoData>(
//            baseUrl: NetworkConstants.baseUrl,
//            path: NetworkConstants.Endpoints.Auth.login
//        )
        return
    }
    
    func loginWithGoogle() -> URL? {
        let parameters: [String:String] = ["redirect_uri": "kiralaapp://oauth2/redirect"]
        let provider = ApiServiceProvider< [String:String]>(method: .get, baseUrl: NetworkConstants.baseUrl, path: NetworkConstants.Endpoints.Auth.loginWithGoogle, data: parameters)
        return try? provider.returnUrlRequest().url
    }
    
    func register(username: String, password: String, completion: @escaping (Result<NoData, ErrorResponse>) -> Void) {
        return
    }
    
    func logout(completion: @escaping (Result<NoData, ErrorResponse>) -> Void) {
        return
    }
    
    func resetPassword(username: String, completion: @escaping (Result<NoData, ErrorResponse>) -> Void) {
        return
    }
    
}
