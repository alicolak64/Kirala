//
//  NetworkError.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

public enum NetworkError : String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}
