//
//  FavoriteState.swift
//  Kirala
//
//  Created by Ali Çolak on 23.05.2024.
//

import Foundation

enum FavoriteState {
    case favorited
    case nonFavorited

    mutating func toggle() {
        self = self == .favorited ? .nonFavorited : .favorited
    }

    init(isFavorite: Bool = false) {
        self = isFavorite ? .favorited : .nonFavorited
    }

    var isFavorite: Bool {
        switch self {
        case .favorited:
            return true
        case .nonFavorited:
            return false
        }
    }
}
