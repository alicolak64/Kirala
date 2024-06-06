//
//  RegisterRequest.swift
//  Kirala
//
//  Created by Ali Çolak on 5.06.2024.
//

import Foundation

struct RegisterRequest: Codable {
    let name: String
    let email: String
    let password: String
}
