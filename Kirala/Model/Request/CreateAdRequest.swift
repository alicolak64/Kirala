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
    
    private enum CodingKeys: String, CodingKey {
        case startDate
        case endDate
        case order
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let startDateString = try container.decode(String.self, forKey: .startDate)
        let endDateString = try container.decode(String.self, forKey: .endDate)
        
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let startDate = formatter.date(from: startDateString),
              let endDate = formatter.date(from: endDateString) else {
            throw DecodingError.dataCorruptedError(forKey: .startDate, in: container, debugDescription: "Date string does not match format expected by formatter.")
        }
        
        self.startDate = startDate
        self.endDate = endDate
        self.order = try container.decode(Bool.self, forKey: .order)
    }
    
    init(startDate: Date, endDate: Date, order: Bool) {
        self.startDate = startDate
        self.endDate = endDate
        self.order = order
    }
    
    
}

struct Location: Codable  {
    let latitude: Double
    let longitude: Double
    let annotationTitle: String?
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
