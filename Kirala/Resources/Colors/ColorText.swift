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
    case white
    
    var lightHex: String {
        switch self {
        case .primary: return "#000000"
        case .secondary: return "#878787"
        case .white: return "#FFFFFF"
        }
    }
    
    var darkHex: String {
        switch self {
        case .primary: return "#FFFFFF"
        case .secondary: return "#878787"
        case .white: return "#000000"
        }
    }
    
}
