//
//  Localization.swift
//  Kirala
//
//  Created by Ali Çolak on 6.05.2024.
//

import Foundation

/// Enum representing different localization tables in the app.
enum LocalizationTable: String {
    case common = "Common"
    case tabBar = "TabBar"
    case emptyState = "EmptyState"
    case alert = "Alert"
    case auth = "Auth"
    case filter = "Filter"
}

/// A struct to manage localization from different tables.
struct Localization {
    
    static let shared = Localization()
    
    // MARK: - Initializers
    
    private init() {}
    
    // MARK: - Public Methods
    
    /// Returns a localized string for a given key and table.
    /// - Parameters:
    ///   - key: The key for the localized string.
    ///   - table: The localization table.
    /// - Returns: The localized string.
    func localizedString(for key: String, table: LocalizationTable) -> String {
        return NSLocalizedString(key, tableName: table.rawValue, bundle: .main, value: "", comment: "")
    }
    
    /// Returns a localized string with formatted arguments for a given key and table.
    /// - Parameters:
    ///   - key: The key for the localized string.
    ///   - table: The localization table.
    ///   - arguments: The arguments to be formatted into the localized string.
    /// - Returns: The formatted localized string.
    func localizedString(for key: String, table: LocalizationTable, arguments: CVarArg...) -> String {
        return String(format: localizedString(for: key, table: table), arguments: arguments)
    }
}
