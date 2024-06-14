//
//  FavoriteService.swift
//  Kirala
//
//  Created by Ali Çolak on 13.06.2024.
//

import Foundation

protocol FavoriteService {
    func getFavorites(token: String, completion: @escaping (Result<BaseResponseArray<ProductResponse>, ErrorResponse>) -> Void)
    func toggleFavorite(productId: String, token: String, completion: @escaping (Result<BaseResponse<NoData>, ErrorResponse>) -> Void)
}

final class FavoriteManager: FavoriteService {
    
    func getFavorites(token: String, completion: @escaping (Result<BaseResponseArray<ProductResponse>, ErrorResponse>) -> Void) {
        
        let provider = ApiServiceProvider<[ProductResponse]>(method: .get, baseUrl: NetworkConstants.baseUrl, path: NetworkConstants.Endpoints.Favorite.getFavorites)
        
        try? APIManager.shared.executeRequest(urlRequest: provider.returnUrlRequest(with: [.authorization(token)]), completion: completion)
    }
    
    func toggleFavorite(productId: String, token: String, completion: @escaping (Result<BaseResponse<NoData>, ErrorResponse>) -> Void) {
        
        let provider = ApiServiceProvider<[String:String]>(method: .put, baseUrl: NetworkConstants.baseUrl, path: NetworkConstants.Endpoints.Favorite.toggleFavorite, data: ["productId": "\(productId)"])
        
        
        try? APIManager.shared.executeRequest(urlRequest: provider.returnUrlRequest(with: [.authorization(token)]), completion: completion)
    }
    
}
