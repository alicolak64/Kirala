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
    
    var lightHex: String {
        switch self {
        case .primary: return "#000000"
        case .secondary: return "#878787"
        case .tertiary: return "#757575"
        case .quaternary: return "#4A4A4A"
        case .white: return "#FFFFFF"
        case .warning: return "#A21C21"
        }
    }
    
    var darkHex: String {
        switch self {
        case .primary: return "#FFFFFF"
        case .secondary: return "#878787"
        case .tertiary: return "#757575"
        case .quaternary: return "#4A4A4A"
        case .white: return "#000000"
        case .warning: return "#A21C21"
        }
    }
    
}
