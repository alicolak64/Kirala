//
//  JSONParameterEncoder.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

/// A struct that encodes parameters as JSON for a URL request.
struct JSONParameterEncoder: ParameterEncoder {
    
    /// Encodes the given parameters and sets them as the HTTP body of the URL request.
    /// - Parameters:
    ///   - urlRequest: The URL request to modify.
    ///   - parameters: The parameters to encode as JSON.
    /// - Throws: An error if encoding fails.
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
}
