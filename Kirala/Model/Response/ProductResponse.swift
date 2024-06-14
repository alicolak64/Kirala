//
//  ProductResponse.swift
//  Kirala
//
//  Created by Ali Çolak on 13.06.2024.
//

import Foundation

struct ProductPageResponse: Codable {
    let numberOfElements: Int
    let pageable: PageableResponse
    let content: [ProductResponse]
    let isLast: Bool
    
    private enum CodingKeys: String, CodingKey {
        case numberOfElements = "numberOfElements"
        case pageable = "pageable"
        case content = "content"
        case isLast = "last"
    }
}

struct PageableResponse: Codable {
    let pageNumber: Int
    let pageSize: Int
}

struct ProductResponse: Codable {
    let id: String
    let brand: String
    let name: String
    let price: Double
    let imageUrl: String?
    let isFavorite: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case brand = "brand"
        case name = "name"
        case price = "price"
        case imageUrl = "imageUrl"
        case isFavorite = "favorite"
    }
}
