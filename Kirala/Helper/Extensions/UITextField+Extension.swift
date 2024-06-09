//
//  UITextField+Extension.swift
//  Kirala
//
//  Created by Ali Çolak on 9.06.2024.
//

import UIKit

extension UITextField {
    
    func setCustomBorder() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 0.5
        self.layer.borderColor = ColorPalette.border.dynamicColor.cgColor
        self.layer.masksToBounds = true
    }
    
}
