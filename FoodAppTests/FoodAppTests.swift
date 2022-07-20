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
    var sut: FoodListViewController!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let mockDataServiceRequestor = MockDataServiceRequestor()
        foodListVM = FoodListViewModel.init(newFoodItemListServiceRequestor: mockDataServiceRequestor)
        sut = makeSUT()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFoodItemApiSuccess() {
        let expect = expectation(description: "API success")
        let requestMapper = FoodItemRequestMapper.mockDataFoodItemList(apiType: .mockApi)
        Task {
            await foodListVM.fetchFoodItemList(with: requestMapper)
            expect.fulfill()
        }
        waitForExpectations(timeout: 5)
        XCTAssertTrue(foodListVM.foodItemsArray?.count ?? 0 > 0, "test passed")
        if foodListVM.foodItemsArray?.count ?? 0 > 0 {
            for item in foodListVM.foodItemsArray! {
                XCTAssertNotNil(item.barcode, "food data is not nil")
            }
        }
    }

    func testFoodItemApiFailure() {
        let expect = expectation(description: "API invaild Error")
        let requestMapper = FoodItemRequestMapper.mockDataFoodItemList(apiType: .invalidApi)
        Task {
            await foodListVM.fetchFoodItemList(with: requestMapper)
            expect.fulfill()
        }
        waitForExpectations(timeout: 5)
        XCTAssertNil(foodListVM.foodItemsArray, "food array not initialised as no data received")
    }

    func testViewDidLoadCallsPresenter() {
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
        sut.viewDidLoad()
        return sut
    }

    override func tearDown() {
        super.tearDown()
        self.foodListVM = nil
    }
}
