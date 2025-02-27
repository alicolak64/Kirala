//
//  URLRequest+Extensions.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

extension URLRequest {
    
    /// A computed property to get and set HTTP headers.
    var headers: HTTPHeaders {
        get {
            allHTTPHeaderFields.map(HTTPHeaders.init) ?? HTTPHeaders()
        }
        set {
            allHTTPHeaderFields = newValue.dictionary
        }
    }
}
