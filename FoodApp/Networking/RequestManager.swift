//
//  RequestManager.swift
//  FoosApp
//
//  Created by VenkateswaraReddy Nandipati on 11/07/22.
//

import Foundation

enum ServiceRequestMethod: String {
    case  getFoodItemList = "get_Food_Item_list"
}

enum ApiRequestType: String {
    case get = "GET"
}

struct ServiceRequestUtility {
    func getURLStringForMethod(method: ServiceRequestMethod) -> String {
        switch method {
        case .getFoodItemList:
            return Constants.URLString.getFoodItem
        }
    }
    func getURLFromString(urlString: String) -> URL? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        return url
    }
}

enum ApiType {
    case mockApi
    case liveApi
    case invalidApi
}

protocol SetUpApiRequestProtocol {
    var apiType: ApiType {get}
    var apiMethod: ServiceRequestMethod {get}
    var apiURL: URL? {get}
    var urlRequest: URLRequest? {get}
}

enum FoodItemRequestMapper {
    case liveDataFoodItemList(apiType: ApiType)
    case mockDataFoodItemList(apiType: ApiType)
}

extension FoodItemRequestMapper: SetUpApiRequestProtocol {
    var urlRequest: URLRequest? {
        guard let _apiUrl = apiURL else {return nil}
        var urlRequest = URLRequest(url: _apiUrl)
        urlRequest.httpMethod = ApiRequestType.get.rawValue
        return urlRequest
    }
    var apiType: ApiType {
        switch self {
        case .liveDataFoodItemList(let apiType):
            return apiType
        case .mockDataFoodItemList(let apiType):
            return apiType
        }
    }
    var apiMethod: ServiceRequestMethod {
        return .getFoodItemList
    }
    var apiURL: URL? {
        var urlString = ServiceRequestUtility().getURLStringForMethod(method: apiMethod)
        urlString = urlString.appending("code=")
        urlString = urlString.appending(Constants.code)
        urlString = urlString.appending("&user_id=")
        urlString = urlString.appending(Constants.user_id)
        urlString = urlString.appending("&api_key=")
        urlString = urlString.appending(Constants.api_key)
        guard let url = ServiceRequestUtility().getURLFromString(urlString: urlString) else {
            return nil
        }
        return url
    }
}
