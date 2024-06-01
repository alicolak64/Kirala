//
//  ServerResponse.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

/// A class representing a server response.
class ServerResponse: Codable, Error {
    
    /// The message returned by the server.
    let returnMessage: String?
    
    /// The code returned by the server.
    let returnCode: Int?
    
    /// Initializes a server response.
    /// - Parameters:
    ///   - returnMessage: The message returned by the server.
    ///   - returnCode: The code returned by the server.
    init(returnMessage: String? = nil, returnCode: Int? = nil) {
        self.returnMessage = returnMessage
        self.returnCode = returnCode
    }
}

extension ServerResponse: LocalizedError {
    /// A localized message describing what error occurred.
    var errorDescription: String? {
        if let returnMessage = returnMessage, let returnCode = returnCode {
            return "\(returnMessage) (Code: \(returnCode))"
        } else if let returnMessage = returnMessage {
            return returnMessage
        } else if let returnCode = returnCode {
            return "Error code: \(returnCode)"
        } else {
            return "Unknown server error"
        }
    }
}
