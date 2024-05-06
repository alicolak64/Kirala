//
//  ServerResponse.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

public class ServerResponse: Codable, Error {
    public let returnMessage: String?
    public let returnCode: Int?

    public init(returnMessage: String? = nil, returnCode: Int? = nil) {
        self.returnMessage = returnMessage
        self.returnCode = returnCode
    }
}
