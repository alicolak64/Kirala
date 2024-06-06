//
//  BaseResponse.swift
//  Kirala
//
//  Created by Ali Çolak on 5.06.2024.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
    let success: Bool
    let message: String
    let data: T?
}

struct BaseResponseArray<T: Codable>: Codable {
    let success: Bool
    let message: String
    let data: [T]?
}

struct NoData: Codable {
}
