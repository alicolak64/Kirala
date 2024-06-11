//
//  ProductService.swift
//  Kirala
//
//  Created by Ali Çolak on 10.06.2024.
//

import UIKit

protocol ProductService {
    func createProduct(product: CreateAd, token: String, completion: @escaping (Result<BaseResponse<NoData>, ErrorResponse>) -> Void)
}

final class ProductManager: ProductService {
    
    func createProduct(product: CreateAd, token: String, completion: @escaping (Result<BaseResponse<NoData>, ErrorResponse>) -> Void) {
        
        let createAdRequest = CreateAdRequest(
            categoryName: product.selectedCategory,
            subcategoryName: product.selectedSubcategory,
            brandName: product.selectedBrand,
            city: product.selectedCity,
            name: product.name,
            price: product.price,
            description: product.description,
            closedRange: product.closedRanges.map({$0.toClosedRange()}),
            location: product.location,
            rentalPeriodRange: RentalPeriodRange(min: product.minRentPeriod, max: product.maxRentPeriod)
        )
        
        let boundary = "Boundary-\(UUID().uuidString)"
        let provider = ApiServiceProvider<CreateAdRequest>(
            method: .post,
            baseUrl: NetworkConstants.baseUrl,
            path: NetworkConstants.Endpoints.Product.createProduct,
            data: createAdRequest
        )
        
        let body = createMultipartFormDataBody(with: createAdRequest, boundary: boundary, images: product.images.map({$0.image}))
                
        guard var request = try? provider.returnUrlRequest(with: [.contentTypeMultipart(boundary), .authorization(token)]) else {
            return
        }
        
        request.httpBody = body
        
        APIManager.shared.executeRequest(urlRequest: request, completion: completion)
    }
    
    private func createMultipartFormDataBody(with parameters: CreateAdRequest, boundary: String, images: [UIImage]) -> Data {
        var body = Data()

        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .iso8601
        guard let jsonData = try? jsonEncoder.encode(parameters) else {
            return body
        }
        
        // JSON Part
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"product\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: application/json\r\n\r\n".data(using: .utf8)!)
        body.append(jsonData)
        body.append("\r\n".data(using: .utf8)!)
        
        // Image Parts
        for (index, image) in images.enumerated() {
            let imageData = image.jpegData(compressionQuality: 0.8)!
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"images\"; filename=\"image\(index).jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
        }

        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        return body
    }
}


