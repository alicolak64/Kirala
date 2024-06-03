//
//  Double+Extension.swift
//  Kirala
//
//  Created by Ali Çolak on 28.05.2024.
//

import Foundation

extension Double {
    
    /// Returns a string representation of the value with the specified number of fraction digits.
    /// - Parameter fractionDigits: The number of fraction digits to use. Default is 2.
    /// - Returns: A string representation of the value with the specified number of fraction digits.
    func toString(fractionDigits: Int = 2) -> String {
        String(format: "%.\(fractionDigits)f", self)
    }
    
    /// Returns a string representation of the value with the specified number of fraction digits and a currency symbol.
    /// - Parameters:
    ///   - fractionDigits: The number of fraction digits to use. Default is 2.
    ///   - currencySymbol: The currency symbol to use. Default is "₺".
    /// - Returns: A string representation of the value with the specified number of fraction digits and a currency symbol.
    func toCurrencyString(fractionDigits: Int = 2, currencySymbol: String = "TL") -> String {
        toString(fractionDigits: fractionDigits) + " \(currencySymbol)"
    }
    
    var formatIntAndString: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
    
}
