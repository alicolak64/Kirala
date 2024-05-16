//
//  ColorBackground.swift
//  Kirala
//
//  Created by Ali Çolak on 13.05.2024.
//

import UIKit

enum ColorBackground: Colorable {
    
    case primary
    case secondary
    case tertiary
    
    var lightHex: String {
        switch self {
        case .primary: return "#F5F5F5"
        case .secondary: return "#FFFFFF"
        case .tertiary: return "#F0F0F0"
        }
    }
    
    var darkHex: String {
        switch self {
        case .primary: return "#000000"
        case .secondary: return "#1A1A1A"
        case .tertiary: return "#333333"
        }
    }
    
}
