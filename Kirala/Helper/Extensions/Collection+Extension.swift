//
//  CollectionExtension.swift
//  UniTurkey
//
//  Created by Ali Çolak on 7.04.2024.
//

import Foundation

/// An extension to safely access elements in a collection.
extension Collection {
    
    // MARK: - Properties (Safe Access)
    
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    /// - Parameter index: The index of the element to access.
    /// - Returns: The element at the specified index if it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
