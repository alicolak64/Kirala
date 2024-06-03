//
//  ExpandState.swift
//  Kirala
//
//  Created by Ali Çolak on 3.06.2024.
//

import Foundation

enum ExpandState {
    case expanded
    case collapsed

    mutating func toggle() {
        self = self == .expanded ? .collapsed : .expanded
    }
    
    init(isExpanded: Bool = false) {
        self = isExpanded ? .expanded : .collapsed
    }
    
    var isExpanded: Bool {
        switch self {
        case .expanded:
            return true
        case .collapsed:
            return false
        }
    }
}

