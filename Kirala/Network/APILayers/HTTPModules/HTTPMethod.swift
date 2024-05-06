//
//  HTTPMethods.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

public struct HTTPMethod: RawRepresentable, Equatable, Hashable {

    public static let delete = HTTPMethod(rawValue: "DELETE")

    public static let get = HTTPMethod(rawValue: "GET")

    public static let post = HTTPMethod(rawValue: "POST")

    public static let put = HTTPMethod(rawValue: "PUT")

    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
