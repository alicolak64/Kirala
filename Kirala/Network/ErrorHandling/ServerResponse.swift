//
//  ServerResponse.swift
//
//
//  Created by Doğukaan Kılıçarslan on 20.10.2022.
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
