//
//  FavoriteAnimation.swift
//  Kirala
//
//  Created by Ali Çolak on 23.05.2024.
//

import Foundation

enum FavoriteAnimation {
    static let keyPath = "transform.scale"
    static let duration = 0.3
    static let keyTimes = [0, 0.25, 0.75, 1.0].map { NSNumber(value: $0) }
    static func getValues(state: FavoriteState) -> [CGFloat] {
        return state.isFavorite ? [1.0, 1.5, 0.9, 1.0] : [1.0, 0.7, 0.4, 0.1]
    }
}
