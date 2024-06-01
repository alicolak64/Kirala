//
//  String+Extensions.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

extension String {
    
    /// Converts the string to a URL.
    /// - Throws: A `NetworkError.missingURL` error if the string cannot be converted to a URL.
    /// - Returns: A URL instance.
    func asURL() throws -> URL {
        guard let url = URL(string: self) else {
            throw NetworkError.missingURL
        }
        return url
    }
}
