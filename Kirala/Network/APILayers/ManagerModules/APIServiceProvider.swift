//
//  APIServiceProvider.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation

protocol URLRequestProtocol {
    func returnUrlRequest(with headers: [HTTPHeaderFields]) throws -> URLRequest
}

/// A class to create and configure URL requests for API services.
class ApiServiceProvider<T: Codable>: URLRequestProtocol {

    // MARK: - Properties
    
    private var method: HTTPMethod
    private var baseUrl: String
    private var path: String?
    private var data: T?
    
    // MARK: - Initializer
    
    /// Initializes an API service provider.
    /// - Parameters:
    ///   - method: The HTTP method for the request.
    ///   - baseUrl: The base URL for the request.
    ///   - path: The path to append to the base URL.
    ///   - data: The data to encode in the request body.
    init(method: HTTPMethod = .get, baseUrl: String, path: String? = nil, data: T? = nil) {
        self.method = method
        self.baseUrl = baseUrl
        self.path = path
        self.data = data
    }
    
    // MARK: - Public Methods
    
    /// Returns a configured URL request.
    /// - Parameter headers: The headers to include in the request.
    /// - Throws: An error if the URL is invalid or encoding fails.
    /// - Returns: A configured URL request.
    func returnUrlRequest(with headers: [HTTPHeaderFields] = [.contentTypeUTF8]) throws -> URLRequest {
        var url = try baseUrl.asURL()
        
        if let path = path {
            url = url.appendingPathComponent(path)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = getHeaders(headers: headers).dictionary
        try configureEncoding(request: &request)
        
        return request
    }
    
    // MARK: - Private Methods
    
    /// Configures the request's encoding based on the HTTP method.
    /// - Parameter request: The URL request to configure.
    /// - Throws: An error if encoding fails.
    private func configureEncoding(request: inout URLRequest) throws {
        switch method {
        case .post, .put:
            try ParameterEncoding.jsonEncoding.encode(urlRequest: &request, parameters: params)
        case .get:
            try ParameterEncoding.urlEncoding.encode(urlRequest: &request, parameters: params)
        default:
            try ParameterEncoding.urlEncoding.encode(urlRequest: &request, parameters: params)
        }
    }
    
    /// Converts the data to a dictionary of parameters.
    private var params: Parameters? {
        return data?.asDictionary()
    }
    
    /// Converts an array of HTTPHeaderFields to HTTPHeaders.
    /// - Parameter headers: The headers to convert.
    /// - Returns: A configured HTTPHeaders instance.
    private func getHeaders(headers: [HTTPHeaderFields]) -> HTTPHeaders {
        var httpHeaders = HTTPHeaders()
        for header in headers {
            httpHeaders.add(HTTPHeader(name: header.value.0, value: header.value.1))
        }
        return httpHeaders
    }
}


