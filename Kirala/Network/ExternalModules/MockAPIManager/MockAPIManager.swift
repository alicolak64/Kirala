//
//  MockAPIManager.swift
//  
//
//  Created by Doğukaan Kılıçarslan on 9.09.2023.
//

import Foundation

class MockAPIManager: APIManagerInterface {
    
    /// A dictionary to store predefined responses for specific URLs.
    private var mockResponses: [URL: (Data)] = [:]
    
    /// Register a mock response for a specific URL.
    ///
    /// - Parameters:
    ///   - url: The URL for which to register the mock response.
    ///   - data: The response data.
    func registerMockResponse(for url: URL, with data: Data) {
        mockResponses[url] = data
    }
    
    /// Simulate executing a network request and invoking the completion handler.
    ///
    /// - Parameters:
    ///   - urlRequest: The URLRequest to be executed.
    ///   - completion: A completion handler to be called with the result.
    func executeRequest<R: Codable>(urlRequest: URLRequest, completion: @escaping (Result<R, ErrorResponse>) -> Void) {
        
        // Check if there's a mock response registered for this URL.
        if let data = mockResponses[urlRequest.url!] {
            // Return the mock response.
            do {
                let decodedResponse = try decodeResponse(data, type: R.self)
                completion(.success(decodedResponse))
            } catch {
                // Simulate a decoding error.
                completion(.failure(ErrorResponse(
                    serverResponse: ServerResponse(returnMessage: "Decoding error", returnCode: 500),
                    apiConnectionErrorType: .dataDecodedFailed("Decoding error"))))
            }
        } else {
            // Simulate an error for unregistered URLs.
            completion(.failure(ErrorResponse(
                serverResponse: ServerResponse(returnMessage: "URL not found", returnCode: 404),
                apiConnectionErrorType: .serverError(404))))
        }
    }
    
    /// Simulate executing a network request asynchronously.
    ///
    /// - Parameters:
    ///   - urlRequest: The URLRequest to be executed.
    /// - Returns: A result containing the decoded response or an error.
    func executeAsyncRequest<R: Codable>(urlRequest: URLRequest) async throws -> R  {
        // Check if there's a mock response registered for this URL.
        if let data = mockResponses[urlRequest.url!] {
            // Return the mock response.
            return try decodeResponse(data, type: R.self)
        } else {
            // Simulate an error for unregistered URLs.
            throw NSError(domain: "MockAPIManager", code: 404)
        }
    }
    
    /// Decode a response from data and URLResponse.
    ///
    /// - Parameters:
    ///   - data: The response data.
    /// - Returns: The decoded response object.
    private func decodeResponse<R: Codable>(_ data: Data,type: R.Type) throws -> R {
        let decoder = JSONDecoder()
        return try decoder.decode(type, from: data)
    }
}
