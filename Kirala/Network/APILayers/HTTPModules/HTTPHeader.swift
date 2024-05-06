//
//  HTTPHeader.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

public struct HTTPHeader: Hashable {
    public let name: String
    public let value: String

    public init(name: String, value: String) {
        self.name = name
        self.value = value
    }
}
