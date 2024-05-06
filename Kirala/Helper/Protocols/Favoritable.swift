//
//  Favoritable.swift
//  UniTurkey
//
//  Created by Ali Çolak on 22.04.2024.
//

import Foundation

protocol Favoritable {
    var isFavorite: Bool { get set }
    mutating func toggleFavorite()
}
