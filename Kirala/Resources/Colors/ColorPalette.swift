//
//  ColorPalette.swift
//  Kirala
//
//  Created by Ali Çolak on 13.05.2024.
//

import UIKit

enum ColorPalette: Colorable{
    
    case appMain
    case border
    case black
    case white
    case gray
    
    
    var lightHex: String {
        switch self {
        case .appMain:
            return "#EB3B59"
        case .border:
            return "#C0C0C0"
        case .black:
            return "#000000"
        case .white:
            return "#FFFFFF"
        case .gray:
            return "#808080"
        }
    }
    
    var darkHex: String {
        switch self {
        case .appMain:
            return "#EB3B59"
        case .border:
            return "#C0C0C0"
        case .black:
            return "#000000"
        case .white:
            return "#FFFFFF"
        case .gray:
            return "#808080"
        }
    }
    
    
    
    
    
}
