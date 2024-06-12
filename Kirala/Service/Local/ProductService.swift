import UIKit

protocol ProductService {
    func createProduct(product: Ad, token: String, completion: @escaping (Result<BaseResponse<NoData>, ErrorResponse>) -> Void)
    func updateProduct(product: Ad, token: String, completion: @escaping (Result<BaseResponse<NoData>, ErrorResponse>) -> Void)
    func deleteProduct(id: String, token: String, completion: @escaping (Result<BaseResponse<NoData>, ErrorResponse>) -> Void)
    func getProductListByUser(token: String, completion: @escaping (Result<BaseResponseArray<MyProductResponse>, ErrorResponse>) -> Void)
    func getProductById(id: String, token: String, completion: @escaping (Result<BaseResponse<MyProductDetailResponse>, ErrorResponse>) -> Void)
}

final class ProductManager: ProductService {
    
    func getProductListByUser(token: String, completion: @escaping (Result<BaseResponseArray<MyProductResponse>, ErrorResponse>) -> Void) {
        let provider = ApiServiceProvider<[String:String]>(method: .get, baseUrl: NetworkConstants.baseUrl, path: NetworkConstants.Endpoints.Product.getProductsByUser, data: [:])

        try? APIManager.shared.executeRequest(urlRequest: provider.returnUrlRequest(with: [.authorization(token)]), completion: completion)
    }
    
    func getProductById(id: String, token: String, completion: @escaping (Result<BaseResponse<MyProductDetailResponse>, ErrorResponse>) -> Void) {
        
        let provider = ApiServiceProvider<[String:String]>(method: .get, baseUrl: NetworkConstants.baseUrl, path: NetworkConstants.Endpoints.Product.getProductById + id, data: [:])
        
        try? APIManager.shared.executeRequest(urlRequest: provider.returnUrlRequest(with: [.authorization(token)]), completion: completion)
    }
    
    func deleteProduct(id: String, token: String, completion: @escaping (Result<BaseResponse<NoData>, ErrorResponse>) -> Void) {
            
            let provider = ApiServiceProvider<[String:String]>(method: .delete, baseUrl: NetworkConstants.baseUrl, path: NetworkConstants.Endpoints.Product.deleteProduct + id, data: [:])
            
            try? APIManager.shared.executeRequest(urlRequest: provider.returnUrlRequest(with: [.authorization(token)]), completion: completion)
    }
    
    func createProduct(product: Ad, token: String, completion: @escaping (Result<BaseResponse<NoData>, ErrorResponse>) -> Void) {
        
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
        
        let body = createMultipartFormDataBody(with: createAdRequest, boundary: boundary, images: product.images.map({$0.image ?? UIImage()}))
        
        guard var request = try? provider.returnUrlRequest(with: [.contentTypeMultipart(boundary), .authorization(token)]) else {
            return
        }
                
        request.httpBody = body
        
        APIManager.shared.executeRequest(urlRequest: request, completion: completion)
    }
    
    func updateProduct(product: Ad, token: String, completion: @escaping (Result<BaseResponse<NoData>, ErrorResponse>) -> Void) {
        
        guard let id = product.id else {
            return
        }
        
        var indices = [Int]()
        var uiImages = [UIImage]()
        
        let images = product.images.enumerated().map { (index, element) -> ImageRequest in
            if let url = element.imageUrl {
                return ImageRequest(index: index, url: url, fileName: nil)
            } else {
                indices.append(index)
                uiImages.append(element.image ?? UIImage())
                return ImageRequest(index: index, url: nil, fileName: "image\(index).jpg")
            }
        }
        
        let updateAdRequest = UpdateAdRequest(
            id: id,
            categoryName: product.selectedCategory,
            subcategoryName: product.selectedSubcategory,
            brandName: product.selectedBrand,
            city: product.selectedCity,
            name: product.name,
            price: product.price,
            description: product.description,
            closedRange: product.closedRanges.map({$0.toClosedRange()}),
            location: product.location,
            rentalPeriodRange: RentalPeriodRange(min: product.minRentPeriod, max: product.maxRentPeriod),
            images: images
        )
        
        let boundary = "Boundary-\(UUID().uuidString)"
        let provider = ApiServiceProvider<UpdateAdRequest>(
            method: .put,
            baseUrl: NetworkConstants.baseUrl,
            path: NetworkConstants.Endpoints.Product.updateProduct,
            data: updateAdRequest
        )
        
        let body = updateMultipartFormDataBody(with: updateAdRequest, boundary: boundary, images: uiImages, indices: indices)
        
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
            body.append("Content-Disposition: form-data; name=\"files\"; filename=\"image\(index).jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
        }

        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        return body
    }
    
    private func updateMultipartFormDataBody(with parameters: UpdateAdRequest, boundary: String, images: [UIImage], indices: [Int]) -> Data {
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
            
            guard let imageIndex = indices[safe: index] else {
                continue
            }
            
            let imageData = image.jpegData(compressionQuality: 0.8)!
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"files\"; filename=\"image\(imageIndex).jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
        }

        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        return body
    }
    
}
