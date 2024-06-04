//
//  AuthRequest.swift
//  Kirala
//
//  Created by Ali Çolak on 4.06.2024.
//

import Foundation

struct AuthRequest: Codable {
    let email: String
    let password: String
}
