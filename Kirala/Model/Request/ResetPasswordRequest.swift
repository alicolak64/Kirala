//
//  ResetPasswordRequest.swift
//  Kirala
//
//  Created by Ali Çolak on 5.06.2024.
//

import Foundation

struct ResetPasswordRequest: Codable {
    let token: String
    let password: String
}
