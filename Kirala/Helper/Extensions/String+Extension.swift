//
//  String+Extension.swift
//  UniTurkey
//
//  Created by Ali Çolak on 7.04.2024.
//

import Foundation

/// An extension to provide additional functionality for strings.
extension String {
    
    // MARK: - Properties
    
    /// Returns the string with each word capitalized.
    var capitalCased: String {
        let components = self.components(separatedBy: " ")
        let capitalized = components.map { $0.capitalized }
        return capitalized.joined(separator: " ")
    }
    
    var isValidPassword: Bool {
        guard self.count >= 7 && self.count <= 64 else { return false }
        
        let letters = CharacterSet.letters
        let digits = CharacterSet.decimalDigits
        
        let hasLetter = self.rangeOfCharacter(from: letters) != nil
        let hasDigit = self.rangeOfCharacter(from: digits) != nil
        
        return hasLetter && hasDigit
    }
    
    /// Checks if the string is a valid URL.
    var isValidUrl: Bool {
        return URL(string: self) != nil
    }
    
    /// Converts the string to a URL.
    var url: URL? {
        return URL(string: self)
    }
    
    /// Converts the string to an image URL, with a fallback if invalid.
    var imageUrl: URL {
        return URL(string: self) ?? noImageURL
    }
    
    var noImageURL: URL {
        return URL(string: "https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg")!
    }
    
    /// Converts the string to an integer.
    var int: Int? {
        return Int(self)
    }
    
    /// Returns the string with leading and trailing whitespace removed.
    var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// Converts English characters to their Turkish equivalents.
    var englishToTurkish: String {
        return self
            .replacingOccurrences(of: "I", with: "ı")
            .replacingOccurrences(of: "C", with: "Ç")
            .replacingOccurrences(of: "S", with: "Ş")
            .replacingOccurrences(of: "G", with: "Ğ")
            .replacingOccurrences(of: "O", with: "Ö")
            .replacingOccurrences(of: "U", with: "Ü")
            .replacingOccurrences(of: "i", with: "ı")
            .replacingOccurrences(of: "c", with: "ç")
            .replacingOccurrences(of: "s", with: "ş")
            .replacingOccurrences(of: "g", with: "ğ")
            .replacingOccurrences(of: "o", with: "ö")
            .replacingOccurrences(of: "u", with: "ü")
    }
    
    /// Converts the string to an NSString.
    var nsString: NSString {
        return self as NSString
    }
    
    // MARK: - Methods
    
    /// Capitalizes each word in the string.
    /// - Returns: The string with each word capitalized.
    @discardableResult
    mutating func capitalCase() -> String {
        self = self.capitalCased
        return self
    }
    
    /// Localizes the string.
    /// - Returns: The localized string.
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
}

// MARK: - Detail String Extension

extension String {
    
    // MARK: - Properties
    
    /// Converts the string to a phone URL.
    var phoneUrl: URL? {
        return URL(string: "tel://\(self)")
    }
    
    /// Converts the string to an email URL.
    var emailUrl: URL? {
        return URL(string: "mailto:\(self)")
    }
    
    /// Converts the string to a Safari URL.
    var safariUrl: URL? {
        return URL(string: "x-web-search://?\(self)")
    }
}
