//
//  CreateAdRequest.swift
//  Kirala
//
//  Created by Ali Çolak on 11.06.2024.
//

import Foundation

struct ClosedRange: Codable {
    let startDate: Date
    let endDate: Date
    let order: Bool
}

struct Location: Codable  {
    let latitude: Double
    let longitude: Double
}

struct RentalPeriodRange: Codable  {
    let min: Int
    let max: Int
}

struct CreateAdRequest: Codable  {
    let categoryName : String
    let subcategoryName : String
    let brandName: String
    let city: String
    let name: String
    let price: Double
    let description: String
    let closedRange: [ClosedRange]
    let location: Location
    let rentalPeriodRange: RentalPeriodRange
}
