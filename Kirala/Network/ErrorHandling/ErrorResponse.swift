//
//  ErrorResponse.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

/// A class representing an error response from an API.
class ErrorResponse: Error {
    
    /// The server response associated with the error, if any.
    let serverResponse: ServerResponse?
    
    /// The API connection error type associated with the error, if any.
    let apiConnectionErrorType: ApiConnectionErrorType?
    
    /// Initializes an error response.
    /// - Parameters:
    ///   - serverResponse: The server response associated with the error.
    ///   - apiConnectionErrorType: The API connection error type associated with the error.
    init(serverResponse: ServerResponse? = nil, apiConnectionErrorType: ApiConnectionErrorType? = nil) {
        self.serverResponse = serverResponse
        self.apiConnectionErrorType = apiConnectionErrorType
    }
}

extension ErrorResponse: LocalizedError {
    /// A localized message describing what error occurred.
    var errorDescription: String? {
        if let serverResponse = serverResponse {
            return "Server error: \(String(describing: serverResponse.returnMessage)) (Code: \(String(describing: serverResponse.returnCode)))"
        } else if let apiConnectionErrorType = apiConnectionErrorType {
            return apiConnectionErrorType.localizedDescription
        } else {
            return "Unknown error occurred"
        }
    }
}
