//
//  ProductDetailResponse.swift
//  Kirala
//
//  Created by Ali Çolak on 14.06.2024.
//

import Foundation

struct ProductDetailResponse: Codable {
    let id: String
    let brand: String
    let name: String
    let city: String
    let price: Double
    let description: String
    let rentalPeriodRange: RentalPeriodRange
    let location: Location
    let imageUrls: [String]
    let closedRanges: [ClosedRange]
    let isFavorite: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case brand = "brand"
        case name = "name"
        case city = "city"
        case price = "price"
        case description = "description"
        case rentalPeriodRange = "rentalPeriodRange"
        case location = "location"
        case imageUrls = "imageUrls"
        case closedRanges = "closedRange"
        case isFavorite = "favorite"
    }
    
}
