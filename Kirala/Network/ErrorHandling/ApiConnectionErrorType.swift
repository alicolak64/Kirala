//
//  ApiConnectionErrorType.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

/// An enum representing different types of API connection errors.
enum ApiConnectionErrorType: Error {
    
    /// Indicates that data is missing, with the associated status code.
    case missingData(Int)
    
    /// Indicates a connection error, with the associated status code.
    case connectionError(Int)
    
    /// Indicates a server error, with the associated status code.
    case serverError(Int)
    
    /// Indicates that data decoding failed, with the associated error message.
    case dataDecodedFailed(String)
    
    /// Indicates that no data was received.
    case noData
    
    /// Returns a localized description for each error type.
    var localizedDescription: String {
        switch self {
        case .missingData(let code):
            return "Missing data with status code: \(code)"
        case .connectionError(let code):
            return "Connection error with status code: \(code)"
        case .serverError(let code):
            return "Server error with status code: \(code)"
        case .dataDecodedFailed(let message):
            return "Data decoding failed with message: \(message)"
        case .noData:
            return "No data received"
        }
    }
}
