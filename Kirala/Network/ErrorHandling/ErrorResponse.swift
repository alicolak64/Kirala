//
//  ErrorResponse.swift
//  
//
//  Created by Doğukaan Kılıçarslan on 8.10.2021.
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
