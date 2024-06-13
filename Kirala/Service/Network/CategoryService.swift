//
//  CategoryService.swift
//  Kirala
//
//  Created by Ali Çolak on 10.06.2024.
//

import Foundation

protocol CategoryService {
    func getCampaignList(completion: @escaping (Result<BaseResponseArray<CampaignResponse>, ErrorResponse>) -> Void)
    func getCategoryList(completion: @escaping (Result<BaseResponseArray<CategoryResponse>, ErrorResponse>) -> Void)
    func getCategoryListWithSubcategories(completion: @escaping (Result<BaseResponseArray<CategoryWithSubcategoryResponse>, ErrorResponse>) -> Void)
    func getSubcategoryList(categoryId: String, completion: @escaping (Result<BaseResponseArray<SubcategoryResponse>, ErrorResponse>) -> Void)
    func getBrandList(completion: @escaping (Result<BaseResponseArray<BrandResponse>, ErrorResponse>) -> Void)
    func getCityList(completion: @escaping (Result<BaseResponseArray<CityResponse>, ErrorResponse>) -> Void)
}

final class CategoryManager: CategoryService {
    
    func getCampaignList(completion: @escaping (Result<BaseResponseArray<CampaignResponse>, ErrorResponse>) -> Void) {
        let provider = ApiServiceProvider<[String:String]>(method: .get, baseUrl: NetworkConstants.baseUrl, path: NetworkConstants.Endpoints.Category.getCampaigns, data: [:])

        try? APIManager.shared.executeRequest(urlRequest: provider.returnUrlRequest(), completion: completion)
    }
    
    func getCategoryListWithSubcategories(completion: @escaping (Result<BaseResponseArray<CategoryWithSubcategoryResponse>, ErrorResponse>) -> Void) {
        let provider = ApiServiceProvider<[String:String]>(method: .get, baseUrl: NetworkConstants.baseUrl, path: NetworkConstants.Endpoints.Category.getCategoryListWithSubcategories, data: [:])

        try? APIManager.shared.executeRequest(urlRequest: provider.returnUrlRequest(), completion: completion)
    }

    func getCategoryList(completion: @escaping (Result<BaseResponseArray<CategoryResponse>, ErrorResponse>) -> Void) {

        let provider = ApiServiceProvider<[String:String]>(method: .get, baseUrl: NetworkConstants.baseUrl, path: NetworkConstants.Endpoints.Category.getCategories, data: [:])

        try? APIManager.shared.executeRequest(urlRequest: provider.returnUrlRequest(), completion: completion)
    }

    func getSubcategoryList(categoryId: String, completion: @escaping (Result<BaseResponseArray<SubcategoryResponse>, ErrorResponse>) -> Void) {
        let provider = ApiServiceProvider<[String:String]>(method: .get, baseUrl: NetworkConstants.baseUrl, path: NetworkConstants.Endpoints.Category.getSubcategories + categoryId, data: [:])

        try? APIManager.shared.executeRequest(urlRequest: provider.returnUrlRequest(), completion: completion)
    }

    func getBrandList(completion: @escaping (Result<BaseResponseArray<BrandResponse>, ErrorResponse>) -> Void) {
        let provider = ApiServiceProvider<[String:String]>(method: .get, baseUrl: NetworkConstants.baseUrl, path: NetworkConstants.Endpoints.Category.getBrands, data: [:])

        try? APIManager.shared.executeRequest(urlRequest: provider.returnUrlRequest(), completion: completion)
    }

    func getCityList(completion: @escaping (Result<BaseResponseArray<CityResponse>, ErrorResponse>) -> Void) {
        let provider = ApiServiceProvider<[String:String]>(method: .get, baseUrl: NetworkConstants.baseUrl, path: NetworkConstants.Endpoints.Category.getCities, data: [:])

        try? APIManager.shared.executeRequest(urlRequest: provider.returnUrlRequest(), completion: completion)
    }

}
