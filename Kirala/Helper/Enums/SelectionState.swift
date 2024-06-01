//
//  SelectionState.swift
//  Kirala
//
//  Created by Ali Çolak on 23.05.2024.
//

import Foundation

enum SelectionState {
    case selected
    case unselected

    mutating func toggle() {
        self = self == .selected ? .unselected : .selected
    }

    init(isSelected: Bool = false) {
        self = isSelected ? .selected : .unselected
    }

    var isSelected: Bool {
        switch self {
        case .selected:
            return true
        case .unselected:
            return false
        }
    }
}
