//
//  FoodItemServiceRequestor.swift
//  FoodApp
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
    func getFoodItemsList(apiRequest: SetUpApiRequestProtocol) async throws -> Result<ItemResponse, CustomError>

}

struct FoodItemServiceRequestor: FoodItemServiceRequestorProtocol {
    func getFoodItemsList(apiRequest: SetUpApiRequestProtocol) async throws -> Result<ItemResponse, CustomError> {
          return try await NetworkManager.initiateServiceRequest(resultType: ItemResponse.self, apiRequest: apiRequest)
    }
}
