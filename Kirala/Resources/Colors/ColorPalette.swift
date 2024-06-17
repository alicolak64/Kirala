//
//  ColorPalette.swift
//  Kirala
//
//  Created by Ali Çolak on 13.05.2024.
//

import UIKit

/// An enum representing the color palette of the application, conforming to the Colorable protocol.
enum ColorPalette: Colorable {
    
    case appPrimary
    case appSecondary
    case appTertiary
    case border
    case lightBorder
    case white
    case gray
    case black
    
    var hex: ColorHex {
        switch self {
        case .appPrimary: return ColorHex(light: "#EB3B59", dark: "#FF5B77")
        case .appSecondary: return ColorHex(light: "#F46E82", dark: "#FF7D97")
        case .appTertiary: return ColorHex(same: "#FCE2E0")
        case .border: return ColorHex(light: "#C0C0C0", dark: "#8A8A8A")
        case .lightBorder: return ColorHex(same: "#E5E5E6")
        case .white: return ColorHex(same: "#FFFFFF")
        case .gray: return ColorHex(light: "#808080", dark: "#A9A9A9")
        case .black: return ColorHex(same: "#000000")
        }
    }
    
}

