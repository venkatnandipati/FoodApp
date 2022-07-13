//
//  ServiceRequestor.swift
//  FoosApp
//
//  Created by VenkateswaraReddy Nandipati on 12/07/22.
//

import Foundation

protocol FoodItemServiceRequestorProtocol {
    /// This function is responsible for fetching fooditem list and returns a tuple of  optional Items Model and  error
    ///
    /// ```
    /// getFoodItemsList
    /// ```
    /// - Warning: The function returns  an optional value also can throw an exception
    /// - Parameter apiRequest:  - an instance of SetUpApiRequestProtocol
    /// - Returns: A tuple of  optional Items Model array and optional error.
    func getFoodItemsList(apiRequest: SetUpApiRequestProtocol) async throws -> (itemModelArray: [Items]?, error: Error?)
}

struct FoodItemServiceRequestor: FoodItemServiceRequestorProtocol {
    func getFoodItemsList(apiRequest: SetUpApiRequestProtocol) async throws -> (itemModelArray: [Items]?, error: Error?) {
        var foodItemsArray = [Items]()
        do {
            let response =  try await NetworkManager.initiateServiceRequest(resultType: ItemResponse.self, apiRequest: apiRequest)
            guard let responseData = response.responseData else {
                return (nil, response.serviceError)
            }
            for item in responseData.items {
                foodItemsArray.append(item)
            }
        } catch let error {
            debugPrint(error.localizedDescription)
            throw CustomError.unexpected
        }
        return foodItemsArray.count > 0 ? (foodItemsArray, nil) : (nil, CustomError.dataError)
    }
}
