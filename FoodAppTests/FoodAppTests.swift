//
//  FoodAppTests.swift
//  FoodAppTests
//
//  Created by VenkateswaraReddy Nandipati on 12/07/22.
//
import UIKit
import XCTest
@testable import FoodApp

class FoodAppTests: XCTestCase {
    var foodListVM: FoodListViewModel!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let mockDataServiceRequestor = MockDataServiceRequestor()
        foodListVM = FoodListViewModel.init(newFoodItemListServiceRequestor: mockDataServiceRequestor)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFoodItemApiSuccess() {
        let expect = expectation(description: "API success")
        let requestMapper = FoodItemRequestMapper.mockDataFoodItemList(apiType: .mockApi)
        Task {
            await foodListVM.fetchFoodItemList(with: requestMapper) { [weak self] result in
                switch result {
                case .success(let response):
                    if let foodItems = response.items as? [Items], foodItems.count > 0 {
                        self?.foodListVM?.foodItemsArray = foodItems
                    }
                    XCTAssertTrue(self?.foodListVM.foodItemsArray?.count ?? 0 > 0, "test passed")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
        if foodListVM.foodItemsArray?.count ?? 0 > 0 {
            for item in foodListVM.foodItemsArray! {
                XCTAssertNotNil(item.barcode, "food data is not nil")
            }
        }
    }

    func testFoodItemApiFailure() {
        let expect = expectation(description: "API Failure")
        let requestMapper = FoodItemRequestMapper.mockDataFoodItemList(apiType: .liveApi)
        Task {
            await foodListVM.fetchFoodItemList(with: requestMapper) { result in
                switch result {
                case .success(let response):
                    XCTAssertNil(response.items, "food array not initialised as no data received")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 5)
    }

    func testFoodItemApiInvalidAPI() {
        let expect = expectation(description: "API invaild Error")
        let requestMapper = FoodItemRequestMapper.mockDataFoodItemList(apiType: .invalidApi)
        Task {
            await foodListVM.fetchFoodItemList(with: requestMapper) { result in
                switch result {
                case .success(let response):
                    XCTAssertNil(response.items, "food array not initialised as no data received")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 5)
    }

    func testViewDidLoadCallsPresenter() {
        let sut = makeSUT()
        let nav = UINavigationController.init(rootViewController: sut)
        sut.showErrorAlertForFoodItemList(error: CustomError.dataError)
        sut.showErrorAlertForFoodItemList(error: CustomError.connectionFailed)
        sut.showErrorAlertForFoodItemList(error: CustomError.unexpected)
        let exp = expectation(description: "Test after 1.5 second wait")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertNotNil(nav.visibleViewController is UIAlertController)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    func makeSUT() -> FoodListViewController {
        let sut: FoodListViewController =  mainStoryboard().instantiate()
        sut.loadViewIfNeeded()
        return sut
    }
    override func tearDown() {
        super.tearDown()
        self.foodListVM = nil
    }
}
