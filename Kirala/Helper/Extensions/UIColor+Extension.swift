//
//  UIColor+Extension.swift
//  UniTurkey
//
//  Created by Ali Çolak on 5.04.2024.
//

import UIKit

/// An extension to provide additional functionality for UIColor.
extension UIColor {
    
    // MARK: - Hex Initialization
    
    /// Initializes a UIColor object with red, green, and blue components.
    /// - Parameters:
    ///   - red: The red component (0-255).
    ///   - green: The green component (0-255).
    ///   - blue: The blue component (0-255).
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    /// Initializes a UIColor object with an RGB integer value.
    /// - Parameter rgb: The RGB value.
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    /// Initializes a UIColor object with a hex string.
    /// - Parameters:
    ///   - hex: The hex string.
    ///   - alpha: The alpha value (default is 1.0).
    convenience init?(hex: String, alpha: Double = 1.0) {
        var pureString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if pureString.hasPrefix("#") {
            pureString.remove(at: pureString.startIndex)
        }
        guard pureString.count == 6 else {
            return nil
        }
        let scanner = Scanner(string: pureString)
        var hexNumber: UInt64 = 0
        
        if scanner.scanHexInt64(&hexNumber) {
            self.init(
                red: CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(hexNumber & 0x0000FF) / 255.0,
                alpha: CGFloat(alpha)
            )
            return
        }
        return nil
    }
    
    // MARK: - 1x1 Image
    
    /// Converts the UIColor to a 1x1 UIImage.
    /// - Returns: A 1x1 UIImage with the color.
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
    
    // MARK: - Dynamic Color
    
    /// Creates a dynamic UIColor object that changes based on the user interface style (light or dark mode).
    /// - Parameters:
    ///   - light: The color to use in light mode.
    ///   - dark: The color to use in dark mode.
    /// - Returns: A dynamic UIColor object.
    static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                return traitCollection.userInterfaceStyle == .dark ? dark : light
            }
        } else {
            return light
        }
    }
    
    // MARK: - Hex String
    
    /// Converts the UIColor to a hex string.
    /// - Returns: A hex string representing the color.
    var hexString: String {
        guard let components = cgColor.components else {
            return "#000000"
        }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        let a = cgColor.alpha
        if a < 1.0 {
            return String(format: "#%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(Float(a) * 255))
        } else {
            return String(format: "#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
}
