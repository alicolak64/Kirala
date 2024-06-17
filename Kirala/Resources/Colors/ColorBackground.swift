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
    case quaternary
    case warning
    
    
    var hex: ColorHex {
        switch self {
        case .primary: return ColorHex(light: "#FFFFFF", dark: "#1A1A1A")
        case .secondary: return ColorHex(light: "#F5F5F5", dark: "#0D0D0D")
        case .tertiary: return ColorHex(light: "#F0F0F0", dark: "#333333")
        case .quaternary: return ColorHex(same: "#515151")
        case .warning: return ColorHex(same: "#F6DDE1")
        }
    }
    
}
