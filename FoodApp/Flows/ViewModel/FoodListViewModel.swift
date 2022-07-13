//
//  MoviesViewModel.swift
//  FoosApp
//
// Created by VenkateswaraReddy Nandipati on 11/07/22.
//

import Foundation

protocol FoodListViewProtocol {
    func getFoodItemsList() async
    var reloadFoodItemsList: (([Items]) -> Void)? { get  set}
    var showDataFetchError: ((Error) -> Void)? { get  set}
}

final class FoodListViewModel: FoodListViewProtocol {
    var reloadFoodItemsList: (([Items]) -> Void)?
    var showDataFetchError: ((Error) -> Void)?
    var dataFetchError: Error? {
        didSet {
            guard let _dataFetchError = dataFetchError else { return  }
            showDataFetchError?(_dataFetchError)
        }
    }
    var foodItemsArray: [Items]?
    var foodItemsData = [Items]() {
        didSet {
            reloadFoodItemsList?(foodItemsData)
        }
    }
    private var newFoodItemListServiceRequestor: FoodItemServiceRequestorProtocol
    init(newFoodItemListServiceRequestor: FoodItemServiceRequestorProtocol) {
        self.newFoodItemListServiceRequestor = newFoodItemListServiceRequestor
    }
    func getFoodItemsList() async {
        let requestMapper = FoodItemRequestMapper.liveDataFoodItemList(apiType: .liveApi)
        await fetchFoodItemList(with: requestMapper)
    }
    func fetchFoodItemList(with requestMapper: FoodItemRequestMapper) async {
        do {
            let responseData = try await newFoodItemListServiceRequestor.getFoodItemsList(apiRequest: requestMapper)
            if let err = responseData.error {
                dataFetchError = err
            } else {
                if let foodItems = responseData.itemModelArray, foodItems.count > 0 {
                    foodItemsArray = foodItems
                    foodItemsData = foodItems
                } else {
                    dataFetchError =  CustomError.dataError
                }
            }
        } catch let serviceError {
            dataFetchError =  serviceError
        }
    }
}
