//
//  File.swift
//  
//
//  Created by Doğukaan Kılıçarslan on 8.10.2021.
//

import Foundation

extension String {
    
    func asURL() throws -> URL {
        guard let url = URL(string: self) else { throw NetworkError.missingURL }
        return url
    }
}

extension String {
    
    func toLocalize() -> String{
        return NSLocalizedString(self, comment: "")
    }
    
}
