//
//  APIServiceProvider.swift
//  
//
//  Created by Doğukaan Kılıçarslan on 21.10.2022.
//

import Foundation

protocol URLRequestProtocol {
    func returnUrlRequest(with headers: [HTTPHeaderFields]) throws -> URLRequest
}

open class ApiServiceProvider<T: Codable>: URLRequestProtocol {

    private var method: HTTPMethod
    private var baseUrl: String
    private var path: String?
    private var data: T?
    
    public init(method: HTTPMethod = .get,
         baseUrl: String,
         path: String? = nil,
         data: T? = nil) {
        
        self.method = method
        self.baseUrl = baseUrl
        self.path = path
        self.data = data
    }
    
    public func returnUrlRequest(with headers: [HTTPHeaderFields] = [.contentTypeUTF8]) throws -> URLRequest {
        var url = try baseUrl.asURL()
        
        if let path = path {
            url = url.appendingPathComponent(path)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.headers = getHeaders(headers: headers)
        try configureEncoding(request: &request)
        
        return request
    }
    
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
    
    private var params: Parameters? {
        return data.asDictionary()
    }
    
    private func getHeaders(headers: [HTTPHeaderFields]) -> HTTPHeaders {
        var httpHeaders = HTTPHeaders()
        for header in headers {
            httpHeaders.add(HTTPHeader(name: header.value.0, value: header.value.1))
        }
        return httpHeaders
    }
}
