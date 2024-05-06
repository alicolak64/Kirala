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
    
    func getLocalizeText(for key: String, table: LocalizationTable) -> String {
        NSLocalizedString(key, tableName: table.rawValue, bundle: Bundle.main, value: "", comment: "")
    }
    
}
