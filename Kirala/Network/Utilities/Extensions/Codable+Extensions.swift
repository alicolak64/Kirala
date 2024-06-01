//
//  File.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

extension Encodable {
    
    /// Converts the encodable object to a dictionary.
    /// - Returns: A dictionary representation of the object, or an empty dictionary if encoding fails.
    func asDictionary() -> Parameters {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .formatted(CodableDateFormatter.outgoingDateFormatter)
            let data = try encoder.encode(self)
            return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] ?? [:]
        } catch {
            return [:]
        }
    }
    
    /// Converts the encodable object to JSON data.
    /// - Returns: The JSON data representation of the object, or nil if encoding fails.
    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    /// Converts the encodable object to a JSON string.
    /// - Returns: The JSON string representation of the object, or nil if encoding fails.
    var jsonString: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

class CodableDateFormatter {
    
    /// A date formatter for outgoing dates.
    static let outgoingDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
