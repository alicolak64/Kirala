//
//  ApiConnectionErrorType.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

public enum ApiConnectionErrorType {
    case missingData(Int)
    case connectionError(Int)
    case serverError(Int)
    case dataDecodedFailed(String)
    case noData
}
