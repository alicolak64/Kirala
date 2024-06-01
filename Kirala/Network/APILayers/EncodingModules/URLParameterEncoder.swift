//
//  URLParameterEncoder.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

/// A protocol for parameter encoders.
protocol ParameterEncoder {
    /// Encodes parameters into the URLRequest.
    /// - Parameters:
    ///   - urlRequest: The URLRequest to encode parameters into.
    ///   - parameters: The parameters to encode.
    /// - Throws: An error if encoding fails.
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

/// A struct to encode parameters as URL parameters.
struct URLParameterEncoder: ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else {
            throw NetworkError.missingURL
        }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = parameters.map {
                URLQueryItem(name: $0.key, value: "\($0.value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
            }
            
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}
