//
//  NetworkError.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

/// An enum representing various network errors.
enum NetworkError: String, Error {
    
    /// The parameters were nil.
    case parametersNil = "Parameters were nil."
    
    /// Parameter encoding failed.
    case encodingFailed = "Parameter encoding failed."
    
    /// The URL is nil.
    case missingURL = "URL is nil."
}

// Conform to LocalizedError to provide a better error description
extension NetworkError: LocalizedError {
    var errorDescription: String? {
        return NSLocalizedString(rawValue, comment: "")
    }
}
