//
//  APIManager.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import Foundation
import Network

/// A protocol defining the interface for the API manager.
protocol APIManagerInterface {
    func executeRequest<R: Codable>(urlRequest: URLRequest, completion: @escaping (Result<R, ErrorResponse>) -> Void)
    func executeAsyncRequest<R: Codable>(urlRequest: URLRequest) async throws -> R
}

/// A class to manage API requests.
class APIManager: APIManagerInterface {
    static let shared = APIManager()
    
    // MARK: - Properties
    
    private let session: URLSession
    private var jsonDecoder = JSONDecoder()
    private var apiCallListener: ApiCallListener?
    
    // MARK: - Initializer
    
    private init(apiCallListener: ApiCallListener? = nil) {
        self.apiCallListener = apiCallListener
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForResource = 300
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        self.session = URLSession(configuration: config)
    }
    
    // MARK: - Public Methods
    
    /// Executes an asynchronous network request and decodes the response.
    ///
    /// - Parameters:
    ///   - urlRequest: The URLRequest to be executed.
    ///   - completion: A completion handler that receives the result of the request.
    func executeRequest<R: Codable>(urlRequest: URLRequest, completion: @escaping (Result<R, ErrorResponse>) -> Void) {
        apiCallListener?.onPreExecute()
        debugPrint(urlRequest)
        session.dataTask(with: urlRequest) { [weak self] data, response, error in
            self?.dataTaskHandler(data, response, error, completion: completion)
        }.resume()
    }
    
    /// Executes an asynchronous network request and decodes the response.
    ///
    /// - Parameters:
    ///   - urlRequest: The URLRequest to be executed.
    /// - Returns: A result containing the decoded response or an error.
    func executeAsyncRequest<R: Codable>(urlRequest: URLRequest) async throws -> R {
        apiCallListener?.onPreExecute()
        let (data, response) = try await fetchData(for: urlRequest)
        return try processResponse(data, response)
    }
    
    /// Cancels the current request.
    func cancelRequest() {
        session.invalidateAndCancel()
    }
    
    // MARK: - Private Methods
    
    private func dataTaskHandler<R: Codable>(_ data: Data?, _ response: URLResponse?, _ error: Error?, completion: @escaping (Result<R, ErrorResponse>) -> Void) {
        defer {
            apiCallListener?.onPostExecute()
        }

        if let error = error {
            debugPrint("task handling error: \(error)")
            let errorResponse = ErrorResponse(
                serverResponse: ServerResponse(
                    returnMessage: error.localizedDescription,
                    returnCode: (error as NSError).code),
                apiConnectionErrorType: .serverError((error as NSError).code))
            completion(.failure(errorResponse))
            return
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            let errorResponse = ErrorResponse(
                serverResponse: ServerResponse(
                    returnMessage: "Invalid response from the server",
                    returnCode: -1),
                apiConnectionErrorType: .serverError(-1))
            completion(.failure(errorResponse))
            return
        }

        guard let data = data else {
            let errorResponse = ErrorResponse(
                serverResponse: ServerResponse(
                    returnMessage: "No data received from the server",
                    returnCode: -1),
                apiConnectionErrorType: .noData)
            completion(.failure(errorResponse))
            return
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            let serverError = handleErrorResponse(data: data)
            let errorResponse = ErrorResponse(
                serverResponse: ServerResponse(
                    returnMessage: serverError.returnMessage,
                    returnCode: httpResponse.statusCode),
                apiConnectionErrorType: .serverError(httpResponse.statusCode))
            completion(.failure(errorResponse))
            return
        }

        do {
            jsonDecoder.dateDecodingStrategy = .iso8601
            let dataDecoded = try jsonDecoder.decode(R.self, from: data)
            completion(.success(dataDecoded))
        } catch let error {
            let errorResponse = ErrorResponse(
                serverResponse: ServerResponse(
                    returnMessage: error.localizedDescription,
                    returnCode: (error as NSError).code),
                apiConnectionErrorType: .dataDecodedFailed(error.localizedDescription))
            debugPrint("decoding error: \(errorResponse)")
            completion(.failure(errorResponse))
        }
    }

    
    private func fetchData(for urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        return try await session.data(for: urlRequest)
    }
    
    private func processResponse<R: Codable>(_ data: Data, _ response: URLResponse) throws -> R {
        defer {
            apiCallListener?.onPostExecute()
        }
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw createErrorResponse(response)
        }
        
        return try decodeResponse(data)
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
    
    private func handleErrorResponse(data: Data) -> ServerResponse {
        do {
            let errorResponse = try jsonDecoder.decode(BaseResponse<NoData>.self, from: data)
            debugPrint("error response: \(errorResponse)")
            return ServerResponse(returnMessage: errorResponse.message, returnCode: -1)
        } catch let error {
            debugPrint("error decoding error response: \(error)")
            return ServerResponse(returnMessage: "Unknown server error", returnCode: -1)
        }
    }
    
}
