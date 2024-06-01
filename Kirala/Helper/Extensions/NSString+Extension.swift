//
//  NSString+Extensions.swift
//  Kirala
//
//  Created by Ali Çolak on 18.05.2024.
//

import UIKit

extension NSString {
    
    /// Calculates the width of the string when rendered with the specified font.
    /// - Parameter font: The font used to render the string.
    /// - Returns: The width of the string.
    func width(usingFont font: UIFont) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: attributes)
        return size.width
    }
}
