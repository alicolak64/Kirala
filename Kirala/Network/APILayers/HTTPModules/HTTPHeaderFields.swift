//
//  HTTPHeaderFields.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

/// An enum representing common HTTP header fields.
enum HTTPHeaderFields {
    
    /// Content-Type header with UTF-8 charset.
    case contentTypeUTF8
    
    /// Content-Type header with JSON.
    case contentType
    
    /// Content-Type header with a multipart form data.
    case contentTypeMultipart(String)
    
    /// Authorization header with a token.
    case authorization(String)
    
    /// RapidAPI key header.
    case rapidApi(String)
    
    /// Gzip encoding header.
    case gzip
    
    /// API key header.
    case xApiKey(String)
    
    /// The name and value of the header field.
    var value: (String, String) {
        switch self {
        case .contentType:
            return ("Content-Type", "application/json")
        case .contentTypeUTF8:
            return ("Content-Type", "application/json; charset=utf-8")
        case .contentTypeMultipart(let boundary):
            return ("Content-Type", "multipart/form-data; boundary=\(boundary)")
        case .authorization(let auth):
            return ("Authorization", auth)
        case .rapidApi(let key):
            return ("x-rapidapi-key", key)
        case .gzip:
            return ("Accept-Encoding", "gzip")
        case .xApiKey(let key):
            return ("X-Api-Key", key)
        }
    }
}
