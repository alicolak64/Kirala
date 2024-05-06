//
//  CollectionExtension.swift
//  UniTurkey
//
//  Created by Ali Çolak on 7.04.2024.
//

import Foundation

extension Collection {
    
    // MARK: - Properties(Safe Access)
    
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}
