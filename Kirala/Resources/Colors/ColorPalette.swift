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
    
    /// The hexadecimal color value for light mode.
    var lightHex: String {
        switch self {
        case .appPrimary:
            return "#EB3B59"
        case .appSecondary:
            return "#F46E82"
        case .appTertiary:
            return "#FCE2E0"
        case .border:
            return "#C0C0C0"
        case .lightBorder:
            return "#E5E5E6"
        case .white:
            return "#FFFFFF"
        case .gray:
            return "#808080"
        case .black:
            return "#000000"
        }
    }
    
    /// The hexadecimal color value for dark mode.
    var darkHex: String {
        switch self {
        case .appPrimary:
            return "#FF5B77"
        case .appSecondary:
            return "#FF7D97"
        case .appTertiary:
            return "#FCE2E0"
        case .border:
            return "#8A8A8A"
        case .lightBorder:
            return "#E5E5E6"
        case .white:
            return "#FFFFFF"
        case .gray:
            return "#A9A9A9"
        case .black:
            return "#000000"
        }
    }
}

