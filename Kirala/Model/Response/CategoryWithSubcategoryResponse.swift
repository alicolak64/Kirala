//
//  CategoryWithSubcategoryResponse.swift
//  Kirala
//
//  Created by Ali Çolak on 13.06.2024.
//

import Foundation

struct SubcategoryWithImageResponse: Codable {
    let id: String
    let name: String
    let imageUrl: String?
}

struct CategoryWithSubcategoryResponse: Codable {
    let id: String
    let name: String
    let subcategories: [SubcategoryWithImageResponse]
}
