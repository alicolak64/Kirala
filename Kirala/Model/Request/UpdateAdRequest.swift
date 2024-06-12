//
//  UpdateAdRequest.swift
//  Kirala
//
//  Created by Ali Çolak on 12.06.2024.
//

import Foundation

struct ImageRequest: Codable {
    let index: Int
    let url: String?
    let fileName: String?
}

struct UpdateAdRequest: Codable  {
    let id: String
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
    let images: [ImageRequest]
}
