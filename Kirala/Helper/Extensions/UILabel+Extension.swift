//
//  UILabel+Extension.swift
//  Kirala
//
//  Created by Ali Çolak on 28.05.2024.
//

import UIKit

extension UILabel {
    
    func setAttributedText(with totalString: String, 
                           totalPrice: String,
                           total: String,
                           perDay: String,
                           price: String,
                           totalPriceFont: UIFont,
                           totalFont: UIFont,
                           priceFont: UIFont,
                           perDayFont: UIFont
    ) {
        let attributedString = NSMutableAttributedString(string: totalString)
        
        if let totalRange = totalString.range(of: total) {
            let nsRange = NSRange(totalRange, in: totalString)
            attributedString.addAttribute(.font, value: totalFont, range: nsRange)
        }
        
        if let perDayRange = totalString.range(of: perDay) {
            let nsRange = NSRange(perDayRange, in: totalString)
            attributedString.addAttribute(.font, value: perDayFont, range: nsRange)
        }
        
        if let totalPriceRange = totalString.range(of: totalPrice) {
            let nsRange = NSRange(totalPriceRange, in: totalString)
            attributedString.addAttribute(.font, value: totalPriceFont, range: nsRange)
        }
        
        if let priceRange = totalString.range(of: price) {
            let nsRange = NSRange(priceRange, in: totalString)
            attributedString.addAttribute(.font, value: priceFont, range: nsRange)
        }
        
        self.attributedText = attributedString
    }
    
    func setAttributedText( with totalString: String,
                            perDay: String,
                            price: String,
                            priceFont: UIFont,
                            perDayFont: UIFont ) {
        
        let attributedString = NSMutableAttributedString(string: totalString)
        
        if let perDayRange = totalString.range(of: perDay) {
            let nsRange = NSRange(perDayRange, in: totalString)
            attributedString.addAttribute(.font, value: perDayFont, range: nsRange)
        }
        
        if let priceRange = totalString.range(of: price) {
            let nsRange = NSRange(priceRange, in: totalString)
            attributedString.addAttribute(.font, value: priceFont, range: nsRange)
        }
        
        self.attributedText = attributedString
        
    }
    
    func setAttributedText(with totalString: String,
                           brand: String,
                           brandFont: UIFont,
                           name: String,
                            nameFont: UIFont) {
        
        let attributedString = NSMutableAttributedString(string: totalString)
        
        if let brandRange = totalString.range(of: brand) {
            let nsRange = NSRange(brandRange, in: totalString)
            attributedString.addAttribute(.font, value: brandFont, range: nsRange)
        }
        
        
        if let nameRange = totalString.range(of: name) {
            let nsRange = NSRange(nameRange, in: totalString)
            attributedString.addAttribute(.font, value: nameFont, range: nsRange)
        }
        
        self.attributedText = attributedString
        
    }
    
    func setUnderlineText(with text: String) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        self.attributedText = attributedString
    }
    
    
    
}


