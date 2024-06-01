//
//  Selectable.swift
//  Kirala
//
//  Created by Ali Çolak on 23.05.2024.
//

import Foundation

/// A protocol to handle the favorite status of an item.
protocol Selectable {
    // MARK: - Properties
    
    /// Indicates whether the item is marked as favorite.
    var selectionState: SelectionState { get set }
    
    // MARK: - Methods
    
    /// Toggles the favorite status of the item.
    mutating func toogleSelection()
}

// MARK: - Default Implementation

extension Selectable {
    mutating func toogleSelection() {
        selectionState.toggle()
    }
}

