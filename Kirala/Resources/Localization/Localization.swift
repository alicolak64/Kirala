//
//  Localization.swift
//  Kirala
//
//  Created by Ali Çolak on 6.05.2024.
//

import Foundation

enum LocalizationTable: String {
    case common = "Common"
    case tabBar = "TabBar"
}

struct Localization {
    
    static let common = Localization(table: LocalizationTable.common)
    static let tabBar = Localization(table: LocalizationTable.tabBar)
    
    private let table: LocalizationTable
    
    private init(table: LocalizationTable) {
        self.table = table
    }
    
    func localizedString(for key: String) -> String {
        return NSLocalizedString(key, tableName: table.rawValue, bundle: Bundle.main, value: "", comment: "")
    }
    
    func localizedString(for key: String, arguments: CVarArg...) -> String {
        return String(format: localizedString(for: key), arguments: arguments)
    }
    
}
