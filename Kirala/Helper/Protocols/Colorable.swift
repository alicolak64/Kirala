//
//  Colorable.swift
//  UniTurkey
//
//  Created by Ali Çolak on 5.04.2024.
//

import UIKit

protocol Colorable {
    // MARK: - Properties
    var lightHex: String { get }
    var darkHex: String { get }
    var color: UIColor { get }
    var dynamicColor: UIColor { get }
}

// MARK: - Default Implementation
extension Colorable {
    var lightColor: UIColor {
        UIColor(hex: lightHex) ?? .white
    }
    
    var darkColor: UIColor {
        UIColor(hex: darkHex) ?? .black
    }
    
    var color: UIColor {
        lightColor
    }
    
    var dynamicColor: UIColor {
        UIColor.dynamicColor(light: lightColor, dark: darkColor)
    }
}
