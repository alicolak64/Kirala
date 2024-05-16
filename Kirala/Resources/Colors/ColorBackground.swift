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
    case white
    
    var lightHex: String {
        switch self {
        case .primary: return "#F5F5F5"
        case .secondary: return "#FFFFFF"
        case .white: return "#FFFFFF"
        }
    }
    
    var darkHex: String {
        switch self {
        case .primary: return "#000000"
        case .secondary: return "#F5F5F5"
        case .white: return "#000000"
        }
    }
    
}
