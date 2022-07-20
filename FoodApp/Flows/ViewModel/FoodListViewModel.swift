//
//  FoodListViewModel.swift
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
        await fetchFoodItemList(with: requestMapper) { [weak self] result in
             switch result {
             case .success(let response):
                 if let foodItems = response.items as? [Items], foodItems.count > 0 {
                     self?.foodItemsArray = foodItems
                     self?.foodItemsData = foodItems
                }
             case .failure(let error):
                 self?.dataFetchError = error
             }
        }
    }
    func fetchFoodItemList(with requestMapper: FoodItemRequestMapper, completion: @escaping (Result<ItemResponse, CustomError>) -> Void) async {
        do {
         let result = try await newFoodItemListServiceRequestor.getFoodItemsList(apiRequest: requestMapper)
          completion(result)
        } catch let serviceError {
            dataFetchError =  serviceError
        }
    }
}
