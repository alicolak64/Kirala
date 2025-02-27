//
//  Favoritable.swift
//  UniTurkey
//
//  Created by Ali Çolak on 22.04.2024.
//

import Foundation

/// A protocol to handle the favorite status of an item.
protocol Favoritable {
    // MARK: - Properties
    
    /// Indicates whether the item is marked as favorite.
    var favoriteState: FavoriteState { get set }
    
    // MARK: - Methods
    
    /// Toggles the favorite status of the item.
    mutating func toggleFavorite()
}

// MARK: - Default Implementation

extension Favoritable {
    mutating func toggleFavorite() {
        favoriteState.toggle()
    }
}
