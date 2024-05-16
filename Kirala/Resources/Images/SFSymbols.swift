//
//  SFSymbols.swift
//  Kirala
//
//  Created by Ali Çolak on 13.05.2024.
//

import UIKit

enum Symbols: Symbolable {
    
    case house_fill
    case newspaper_fill
    case shippingbox_fill
    case cart_fill
    case person_fill
    case list_bullet_below_rectangle
    case wifi_slash
    case magnifyingglass_circle_fill
    case star_slash_fill
    case cart_badge_minus
    case exclamationmark_triangle_fill
    case bell_slash_fill
    case rectangle_portrait_on_rectangle_portrait_slash_fill
    
    
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
        case .list_bullet_below_rectangle:
            return "list.bullet.below.rectangle"
        case .wifi_slash:
            return "wifi.slash"
        case .magnifyingglass_circle_fill:
            return "magnifyingglass.circle.fill"
        case .star_slash_fill:
            return "star.slash.fill"
        case .cart_badge_minus:
            return "cart.badge.minus"
        case .exclamationmark_triangle_fill:
            return "exclamationmark.triangle.fill"
        case .bell_slash_fill:
            return "bell.slash.fill"
        case .rectangle_portrait_on_rectangle_portrait_slash_fill:
            return "rectangle.portrait.on.rectangle.portrait.slash.fill"
        }
    }
    
}




