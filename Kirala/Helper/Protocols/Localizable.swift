//
//  Localizable.swift
//  Kirala
//
//  Created by Ali Çolak on 6.06.2024.
//

import Foundation

protocol Localizable {
    var localized: String { get }
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    var localized: String {
        return Localization.shared.localizedString(for: rawValue, table: LocalizationTable(rawValue: String(describing: Self.self)) ?? .common)
    }
}
