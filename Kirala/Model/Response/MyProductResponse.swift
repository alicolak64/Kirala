//
//  MyAdProductResponse.swift
//  Kirala
//
//  Created by Ali Çolak on 12.06.2024.
//

import Foundation

struct MyProductResponse: Codable {
    let id: String
    let brand: String
    let name: String
    let price: Double
    let imageUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case brand = "brand"
        case name = "name"
        case price = "price"
        case imageUrl = "imageUrl"
    }
    
}
