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
    
    // MARK: - Static Properties
    
    static let common = Localization(table: .common)
    static let tabBar = Localization(table: .tabBar)
    static let emptyState = Localization(table: .emptyState)
    static let alert = Localization(table: .alert)
    static let auth = Localization(table: .auth)
    static let filter = Localization(table: .filter)
    
    // MARK: - Instance Properties
    
    private let table: LocalizationTable
    
    // MARK: - Initializers
    
    private init(table: LocalizationTable) {
        self.table = table
    }
    
    // MARK: - Public Methods
    
    /// Returns a localized string for a given key.
    /// - Parameter key: The key for the localized string.
    /// - Returns: The localized string.
    func localizedString(for key: String) -> String {
        return NSLocalizedString(key, tableName: table.rawValue, bundle: Bundle.main, value: "", comment: "")
    }
    
    /// Returns a localized string with formatted arguments.
    /// - Parameters:
    ///   - key: The key for the localized string.
    ///   - arguments: The arguments to be formatted into the localized string.
    /// - Returns: The formatted localized string.
    func localizedString(for key: String, arguments: CVarArg...) -> String {
        return String(format: localizedString(for: key), arguments: arguments)
    }
    
}
