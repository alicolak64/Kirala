//
//  APIManager.swift
//  
//
//  Created by Doğukaan Kılıçarslan on 21.10.2022.
//

import Foundation
import Network


public protocol APIManagerInterface {
    func executeRequest<R: Codable>(urlRequest: URLRequest, completion: @escaping (Result<R, ErrorResponse>) -> Void)
    func executeAsyncRequest<R: Codable>(urlRequest: URLRequest) async throws -> R
}

public class APIManager: APIManagerInterface {
    public static let shared = APIManager()
    
    // Mark: - Session -
    private let session: URLSession
    
    // Mark: - JsonDecoder -
    private var jsonDecoder = JSONDecoder()
    
    //Mark: - apiCallListener -
    private var apiCallListener: ApiCallListener?
    
    public init(apiCallListener: ApiCallListener? = nil) {
        self.apiCallListener = apiCallListener
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForResource = 300
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        self.session = URLSession(configuration: config)
    }
    
    /// Executes an asynchronous network request and decodes the response.
    ///
    /// - Parameters:
    ///   - urlRequest: The URLRequest to be executed.
    ///   - completion: A completion handler that receives the result of the request.
    public func executeRequest<R>(urlRequest: URLRequest, completion: @escaping (Result<R, ErrorResponse>) -> Void) where R : Codable {
        apiCallListener?.onPreExecute()
        debugPrint(urlRequest)
        session.dataTask(with: urlRequest) { [weak self](data, urlResponse, error) in
            self?.dataTaskHandler(data, urlResponse, error, completion: completion)
        }.resume()
    }
    
    private func dataTaskHandler<R: Codable>(_ data: Data?, _ response: URLResponse?, _ error: Error?, completion: @escaping (Result<R, ErrorResponse>) -> Void) {
        defer {
            apiCallListener?.onPostExecute()
        }
        if error != nil {
            // completion failure
            debugPrint("task handling error: \(String(describing: error))")
            completion(.failure(
                ErrorResponse(
                    serverResponse:
                        ServerResponse(
                            returnMessage: error!.localizedDescription,
                            returnCode: error!._code),
                    apiConnectionErrorType: .serverError(error!._code)
                )
            ))
        }
        
        if let data = data {
            do {
//                debugPrint(String(data: data, encoding: .utf8)!)
//                debugPrint(data.jsonString ?? "")
                jsonDecoder.dateDecodingStrategy = .iso8601
                let dataDecoded = try jsonDecoder.decode(R.self, from: data)
//                debugPrint("data: \(data)")
                completion(.success(dataDecoded))
            } catch let error {
                // completion failure
                let errorResponse = ErrorResponse(
                        serverResponse: ServerResponse(
                            returnMessage: error.localizedDescription,
                            returnCode: error._code),
                    apiConnectionErrorType: .dataDecodedFailed(error.localizedDescription))
                debugPrint("decoding error:\(errorResponse)")
            }
        }
    }
    
    public func cancelRequest() {
        session.invalidateAndCancel()
    }
    
    deinit {
        debugPrint("DEINIT APIMANAGER")
    }
    
    /// Executes an asynchronous network request and decodes the response.
    ///
    /// - Parameters:
    ///   - urlRequest: The URLRequest to be executed.
    /// - Returns: A result containing the decoded response or an error.
    public func executeAsyncRequest<R: Codable>(urlRequest: URLRequest) async throws -> R {
        apiCallListener?.onPreExecute()
        let (data, response) = try await fetchData(for: urlRequest)
        return try processResponse(data, response)
    }
    
    private func fetchData(for urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        let (data, response) = try await session.data(for: urlRequest)
        return (data, response)
    }
    
    private func processResponse<R: Codable>(_ data: Data, _ response: URLResponse) throws -> R {
        defer {
            apiCallListener?.onPostExecute()
        }
        if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
            return try decodeResponse(data)
        } else {
            throw createErrorResponse(response)
        }
    }
    
    private func decodeResponse<R: Codable>(_ data: Data) throws -> R {
        return try jsonDecoder.decode(R.self, from: data)
    }
    
    private func createErrorResponse(_ response: URLResponse) -> ErrorResponse {
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
        
        let errorResponse = ErrorResponse(
            serverResponse: ServerResponse(
                returnMessage: "Server returned an error with status code \(statusCode)",
                returnCode: statusCode),
            apiConnectionErrorType: .serverError(statusCode))
        return errorResponse
    }
}
