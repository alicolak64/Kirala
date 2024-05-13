//
//  SFSymbols.swift
//  Kirala
//
//  Created by Ali Çolak on 13.05.2024.
//

import Foundation

enum Symbols: Symbolable {
    
    case house_fill
    case newspaper_fill
    case shippingbox_fill
    case cart_fill
    case person_fill
    
    var symbolName: String {
        switch self {
        case .house_fill:
            return "house.fill"
        case .newspaper_fill:
            return "newspaper.fill"
        case .shippingbox_fill:
            return "shippingbox.fill"
        case .cart_fill:
            return "cart.fill"
        case .person_fill:
            return "person.fill"
        }
    }
    
}
