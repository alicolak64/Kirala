//
//  UserService.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

protocol AuthService {
    func login(username: String, password: String, completion: @escaping (Result<NoData, ApiConnectionErrorType>) -> Void)
    func register(username: String, password: String, completion: @escaping (Result<NoData, ApiConnectionErrorType>) -> Void)
    func logout(completion: @escaping (Result<NoData, ApiConnectionErrorType>) -> Void)
}
