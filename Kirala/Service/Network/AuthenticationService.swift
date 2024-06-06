//
//  UserService.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

protocol AuthenticationService {
    func login(email: String, password: String, completion: @escaping (Result<BaseResponse<LoginResponse>, ErrorResponse>) -> Void)
    func loginWithGoogle() -> URL?
    func register(name: String, email: String, password: String, completion: @escaping (Result<BaseResponse<NoData>, ErrorResponse>) -> Void)
    func logout(completion: @escaping (Result<BaseResponse<NoData>, ErrorResponse>) -> Void)
    func forgotPassword(email: String, completion: @escaping (Result<BaseResponse<NoData>, ErrorResponse>) -> Void)
    func resetPassword(token: String, password: String, completion: @escaping (Result<BaseResponse<NoData>, ErrorResponse>) -> Void)
}

final class AuthenticationManager: AuthenticationService {
    
    func login(email: String, password: String, completion: @escaping (Result<BaseResponse<LoginResponse>, ErrorResponse>) -> Void) {
        
        let parameters = LoginRequest(email: email, password: password)
        
        let provider = ApiServiceProvider<LoginRequest>(method: .post, baseUrl: NetworkConstants.baseUrl, path: NetworkConstants.Endpoints.Auth.login, data: parameters)
                
        try? APIManager.shared.executeRequest(urlRequest: provider.returnUrlRequest(), completion: completion)
    }
    
    func loginWithGoogle() -> URL? {
        let parameters: [String:String] = ["redirect_uri": "kiralaapp://oauth2"]
        let provider = ApiServiceProvider<[String:String]>(method: .get, baseUrl: NetworkConstants.baseUrl, path: NetworkConstants.Endpoints.Auth.loginWithGoogle, data: parameters)
        return try? provider.returnUrlRequest().url
    }
    
    func register(name: String, email: String, password: String, completion: @escaping (Result<BaseResponse<NoData>, ErrorResponse>) -> Void) {
        let parameters = RegisterRequest(name: name, email: email, password: password)
        
        let provider = ApiServiceProvider<RegisterRequest>(method: .post, baseUrl: NetworkConstants.baseUrl, path: NetworkConstants.Endpoints.Auth.register, data: parameters)
                
        try? APIManager.shared.executeRequest(urlRequest: provider.returnUrlRequest(), completion: completion)
    }
    
    func logout(completion: @escaping (Result<BaseResponse<NoData>, ErrorResponse>) -> Void) {
        return
    }
    
    func forgotPassword(email: String, completion: @escaping (Result<BaseResponse<NoData>, ErrorResponse>) -> Void) {
        let parameters = ForgotPasswordRequest(email: email)
        let provider = ApiServiceProvider<ForgotPasswordRequest>(method: .post, baseUrl: NetworkConstants.baseUrl, path: NetworkConstants.Endpoints.Auth.forgotPassword, data: parameters)
        try? APIManager.shared.executeRequest(urlRequest: provider.returnUrlRequest(), completion: completion)
    }
    
    func resetPassword(token: String, password: String, completion: @escaping (Result<BaseResponse<NoData>, ErrorResponse>) -> Void) {
        let parameters = ResetPasswordRequest(token: token, password: password)
        let provider = ApiServiceProvider<ResetPasswordRequest>(method: .post, baseUrl: NetworkConstants.baseUrl, path: NetworkConstants.Endpoints.Auth.resetPassword, data: parameters)
        try? APIManager.shared.executeRequest(urlRequest: provider.returnUrlRequest(), completion: completion)
    }
    
}
