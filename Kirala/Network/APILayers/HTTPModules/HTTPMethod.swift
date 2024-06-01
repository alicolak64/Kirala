//
//  HTTPMethod.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

/// A struct representing an HTTP method.
struct HTTPMethod: RawRepresentable, Equatable, Hashable {

    /// DELETE method.
    static let delete = HTTPMethod(rawValue: "DELETE")

    /// GET method.
    static let get = HTTPMethod(rawValue: "GET")

    /// POST method.
    static let post = HTTPMethod(rawValue: "POST")

    /// PUT method.
    static let put = HTTPMethod(rawValue: "PUT")
    
    /// HEAD method.
    static let head = HTTPMethod(rawValue: "HEAD")
    
    /// PATCH method.
    static let patch = HTTPMethod(rawValue: "PATCH")
    
    /// OPTIONS method.
    static let options = HTTPMethod(rawValue: "OPTIONS")

    /// The raw value of the HTTP method.
    let rawValue: String

    /// Initializes an HTTP method with a raw value.
    /// - Parameter rawValue: The raw value of the HTTP method.
    init(rawValue: String) {
        self.rawValue = rawValue
    }
}
