//
//  ParameterEncoding.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

/// An enum to specify the type of parameter encoding.
enum ParameterEncoding {
    case urlEncoding
    case jsonEncoding
    
    /// Encodes parameters into the URLRequest based on the encoding type.
    /// - Parameters:
    ///   - urlRequest: The URLRequest to encode parameters into.
    ///   - parameters: The parameters to encode.
    /// - Throws: An error if encoding fails.
    func encode(urlRequest: inout URLRequest, parameters: Parameters?) throws {
        guard let parameters = parameters else { return }
        
        do {
            switch self {
            case .urlEncoding:
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: parameters)
                
            case .jsonEncoding:
                try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: parameters)
            }
        } catch {
            throw error
        }
    }
}
