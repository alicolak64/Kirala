//
//  SearchProductPageResponse.swift
//  Kirala
//
//  Created by Ali Çolak on 14.06.2024.
//

import Foundation

struct SearchProductPageResponse: Codable {
    let numberOfElements: Int
    let pageable: PageableResponse
    let content: SearchProductContentResponse
    let isLast: Bool
    
    private enum CodingKeys: String, CodingKey {
        case numberOfElements = "numberOfElements"
        case pageable = "pageable"
        case content = "content"
        case isLast = "last"
    }
}

struct RenterResponse: Codable {
    let id: String
    let name: String
    let isSelected: Bool
    
    // MARK: - Coding Keys

    private enum CodingKeys: String, CodingKey {
        // MARK: Cases
        case id = "id"
        case name = "name"
        case isSelected = "selected"
    }
    
}


struct SearchProdutResponse: Codable {
    let id: String
    let brand: String
    let name: String
    let price: Double
    let imageUrls: [String?]
    let isFavorite: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case brand = "brand"
        case name = "name"
        case price = "price"
        case imageUrls = "imageUrls"
        case isFavorite = "favorite"
    }
}

struct SearchProductContentResponse: Codable {
    let products: [SearchProdutResponse]
    let subcategories: [SubcategoryFilterResponse]
    let brands: [BrandFilterResponse]
    let cities: [CityFilterResponse]
    let renters: [RenterResponse]
}

struct SubcategoryFilterResponse: Codable {

    let id: String
    let name: String
    let isSelected: Bool

    // MARK: - Coding Keys

    private enum CodingKeys: String, CodingKey {
        // MARK: Cases
        case id = "id"
        case name = "name"
        case isSelected = "selected"
    }

}

struct BrandFilterResponse: Codable {

    let id: String
    let name: String
    let isSelected: Bool

    // MARK: - Coding Keys

    private enum CodingKeys: String, CodingKey {
        // MARK: Cases
        case id = "id"
        case name = "name"
        case isSelected = "selected"
    }

}

struct CityFilterResponse: Codable {
    let id: Int
    let name: String
    let isSelected: Bool

    // MARK: - Coding Keys

    private enum CodingKeys: String, CodingKey {
        // MARK: Cases
        case id = "id"
        case name = "name"
        case isSelected = "selected"
    }

}
