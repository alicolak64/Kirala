//
//  ErrorResponse.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

public class ErrorResponse: Error {
    public let serverResponse: ServerResponse?
    public let apiConnectionErrorType: ApiConnectionErrorType?

    public init(serverResponse: ServerResponse? = nil, apiConnectionErrorType: ApiConnectionErrorType? = nil) {
        self.serverResponse = serverResponse
        self.apiConnectionErrorType = apiConnectionErrorType
    }

}
