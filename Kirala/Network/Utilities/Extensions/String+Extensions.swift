//
//  File.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

extension String {
    
    func asURL() throws -> URL {
        guard let url = URL(string: self) else { throw NetworkError.missingURL }
        return url
    }
}
