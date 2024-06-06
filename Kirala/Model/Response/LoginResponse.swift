//
//  LoginResponse.swift
//  Kirala
//
//  Created by Ali Çolak on 5.06.2024.
//

import Foundation

struct LoginResponse: Codable {
    
    let token: String
    let tokenType: String
    
    // MARK: - Coding Keys
    
    private enum CodingKeys: String, CodingKey {
        // MARK: Cases
        case token = "accessToken"
        case tokenType = "tokenType"
    }
    
}
