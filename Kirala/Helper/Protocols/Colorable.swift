//
//  Colorable.swift
//  UniTurkey
//
//  Created by Ali Çolak on 5.04.2024.
//

import UIKit

struct ColorHex {
    let lightHex: String?
    let darkHex: String?
    
    // Init method for different light and dark colors
    init(light: String, dark: String) {
        self.lightHex = light
        self.darkHex = dark
    }

    // Init method for the same color in light and dark modes
    init(same: String) {
        self.lightHex = same
        self.darkHex = same
    }
    
}

protocol Colorable {
    // MARK: - Properties
    var hex: ColorHex { get }
    var color: UIColor { get }
    var dynamicColor: UIColor { get }
}

extension Colorable {
    
    var lightColor: UIColor {
        UIColor(hex: hex.lightHex ?? "") ?? UIColor.systemBackground
    }
    
    var darkColor: UIColor {
        UIColor(hex: hex.darkHex ?? "") ?? UIColor.label
    }
    
    var color: UIColor {
        lightColor
    }
    
    var dynamicColor: UIColor {
        UIColor.dynamicColor(light: lightColor, dark: darkColor)
    }
}
