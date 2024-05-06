//
//  NetworkError.swift
//  
//
//  Created by Doğukaan Kılıçarslan on 8.10.2021.
//

import Foundation

public enum NetworkError : String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}
