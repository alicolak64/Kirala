//
//  SubcategoryResponse.swift
//  Kirala
//
//  Created by Ali Çolak on 10.06.2024.
//

import Foundation

struct SubcategoryResponse: Codable {

    let id: String
    let name: String

    // MARK: - Coding Keys

    private enum CodingKeys: String, CodingKey {
        // MARK: Cases
        case id = "id"
        case name = "name"
    }

}
