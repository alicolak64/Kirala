//
//  HTTPHeaders.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

/// A struct representing a collection of HTTP headers.
struct HTTPHeaders {
    
    private var headers: [HTTPHeader] = []
    
    /// Initializes an empty collection of HTTP headers.
    init() {}
    
    /// Initializes a collection of HTTP headers from a dictionary.
    /// - Parameter dictionary: A dictionary containing header names and values.
    init(_ dictionary: [String: String]) {
        self.init()
        dictionary.forEach { update(HTTPHeader(name: $0.key, value: $0.value)) }
    }
    
    /// Adds a new HTTP header to the collection.
    /// - Parameter header: The HTTP header to add.
    mutating func add(_ header: HTTPHeader) {
        update(header)
    }
    
    /// Updates the value of an existing header or adds a new one if it does not exist.
    /// - Parameters:
    ///   - name: The name of the header.
    ///   - value: The value of the header.
    mutating func update(name: String, value: String) {
        update(HTTPHeader(name: name, value: value))
    }
    
    /// Updates the value of an existing header or adds a new one if it does not exist.
    /// - Parameter header: The HTTP header to update.
    mutating func update(_ header: HTTPHeader) {
        if let index = headers.firstIndex(of: header) {
            headers[index] = header
        } else {
            headers.append(header)
        }
    }
    
    /// Removes a header from the collection.
    /// - Parameter name: The name of the header to remove.
    mutating func remove(name: String) {
        headers.removeAll { $0.name == name }
    }
    
    /// Returns the headers as a dictionary.
    var dictionary: [String: String] {
        return headers.reduce(into: [String: String]()) { result, header in
            result[header.name] = header.value
        }
    }
}
