//
//  Bundle+Extension.swift
//  Kirala
//
//  Created by Ali Çolak on 24.05.2024.
//

import Foundation

extension Bundle {
    
    var identifier: String {
        return Bundle.main.bundleIdentifier ?? ""
    }
    
}
