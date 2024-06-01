//
//  UserService.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

protocol AuthenticationService {
    func login(username: String, password: String, completion: @escaping (Result<NoData, ErrorResponse>) -> Void)
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
