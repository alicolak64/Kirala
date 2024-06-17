//
//  ColorText.swift
//  Kirala
//
//  Created by Ali Çolak on 13.05.2024.
//

import UIKit

enum ColorText: Colorable{
    
    case primary
    case secondary
    case tertiary
    case quaternary
    case warning
    
    case white
    
    var hex: ColorHex {
        switch self {
        case .primary: return ColorHex(light: "#000000", dark: "#FFFFFF")
        case .secondary: return ColorHex(same: "#878787")
        case .tertiary: return ColorHex(same: "#757575")
        case .quaternary: return ColorHex(same: "#4A4A4A")
        case .white: return ColorHex(light: "#FFFFFF", dark: "#000000")
        case .warning: return ColorHex(same: "#A21C21")
        }
    }
        
}
