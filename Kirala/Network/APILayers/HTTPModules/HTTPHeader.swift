//
//  HTTPHeader.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

/// A struct representing an HTTP header.
struct HTTPHeader: Hashable {
    
    /// The name of the HTTP header.
    let name: String
    
    /// The value of the HTTP header.
    let value: String

    /// Initializes an HTTPHeader with a name and value.
    /// - Parameters:
    ///   - name: The name of the HTTP header.
    ///   - value: The value of the HTTP header.
    init(name: String, value: String) {
        self.name = name
        self.value = value
    }
}
