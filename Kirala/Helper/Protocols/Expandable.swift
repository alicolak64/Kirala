//
//  Expandable.swift
//  Kirala
//
//  Created by Ali Çolak on 3.06.2024.
//

import Foundation

/// A protocol to handle the favorite status of an item.
protocol Expandable {
    // MARK: - Properties
    
    /// Indicates whether the item is marked as favorite.
    var expandedState: ExpandState { get set }
    
    // MARK: - Methods
    
    /// Toggles the favorite status of the item.
    mutating func toggleExpandedState()
}

// MARK: - Default Implementation

extension Expandable {
    mutating func toggleExpandedState() {
        expandedState.toggle()
    }
}
