//
//  ApiConnectionErrorType.swift
//  
//
//  Created by Doğukaan Kılıçarslan on 20.10.2022.
//

import Foundation

public enum ApiConnectionErrorType {
    case missingData(Int)
    case connectionError(Int)
    case serverError(Int)
    case dataDecodedFailed(String)
    case noData
}
