//
//  MockDataRequestor.swift
//  FoosApp
//
//  Created by VenkateswaraReddy Nandipati on 12/07/22.
//

import Foundation
import UIKit
enum MockDataResponseType: String {
    case successWithResult = "success_with_result"
    case failedWithError = "failed_with_error"
    case unknown = "unknown_type"
}

extension SetUpApiRequestProtocol {
    func getMockDataResponseType(apiType: ApiType) -> MockDataResponseType {
        switch apiType {
        case .mockApi:
            return .successWithResult
        case .liveApi:
            return .failedWithError
        case .invalidApi:
            return .failedWithError
        }
    }
}

private struct MockDataFiles {
    static let FoodItemListFull = "FoodItems"
}

protocol MockDataRequestorProtocol {
    func getMockDataResponse(responseType: MockDataResponseType?, method: ServiceRequestMethod?) -> Data?
}

struct MockDataServiceRequestor: FoodItemServiceRequestorProtocol {

    func getFoodItemsList(apiRequest: SetUpApiRequestProtocol) async throws -> (itemModelArray: [Items]?, error: Error?) {
        let responseType = apiRequest.getMockDataResponseType(apiType: apiRequest.apiType)
        let method = apiRequest.apiMethod
        switch method {
        case .getFoodItemList:
            guard let mockData = getMockDataResponseFoodItems(responseType: responseType) else {
                return (nil, CustomError.unexpected)
            }
            do {
                let mockFoodItemsData = try await parseMockData(resultType: ItemResponse.self, mockData: mockData, apiRequest: apiRequest)
                guard let responseData = mockFoodItemsData.responseData else {
                    return (nil, mockFoodItemsData.serviceError)
                }
                var foodItemsArray = [Items]()
                for item in responseData.items {
                    foodItemsArray.append(item)
                }
                return (foodItemsArray, nil)
            } catch let error {
                debugPrint(error.localizedDescription)
                return (nil, CustomError.unexpected)
            }
        }
    }

    private func parseMockData<T: Decodable>(resultType: T.Type,
                                             mockData: Data,
                                             apiRequest: SetUpApiRequestProtocol) async throws -> (responseData: T?, serviceError: Error?) {
        if !Reachability.isConnectedToNetwork() {
            return (nil, CustomError.connectionFailed)
        }
        do {
            let results  =  try JSONDecoder().decode(T.self, from: mockData)
            return (results, nil)
        } catch let error {
            debugPrint(error.localizedDescription)
            return (nil, CustomError.unexpected)
        }
    }

    private func getMockDataResponseFoodItems(responseType: MockDataResponseType) -> Data? {
        switch responseType {
        case .successWithResult:
            debugPrint("success with result")
            return getStubDataFromFile(fileName: MockDataFiles.FoodItemListFull)
        case .failedWithError:
            debugPrint("failed with error")
            return nil
        default:
            debugPrint("default case")
        }
        return nil
    }

    private func getStubDataFromFile(fileName: String) -> Data? {
        guard let jsonData = readFile(forName: fileName) else {
            return nil
        }
        return jsonData
    }

    private func readFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
            return nil
        }
        return nil
    }
}
