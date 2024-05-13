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
    
    var lightHex: String {
        switch self {
        case .primary: return "#000000"
        case .secondary: return "#FFFFFF"
        }
    }
    
    var darkHex: String {
        switch self {
        case .primary: return "#FFFFFF"
        case .secondary: return "#000000"
        }
    }
    
}
