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
    
    var lightHex: String {
        switch self {
        case .primary: return "#FFFFFF"
        case .secondary: return "#F5F5F5"
        case .tertiary: return "#F0F0F0"
        case .quaternary: return "#515151"
        case .warning: return "#F6DDE1"
            
        }
    }
    
    var darkHex: String {
        switch self {
        case .primary: return "#1A1A1A"
        case .secondary: return "#0D0D0D"
        case .tertiary: return "#333333"
        case .quaternary: return "#515151"
        case .warning: return "#F6DDE1"
        }
    }
    
}
