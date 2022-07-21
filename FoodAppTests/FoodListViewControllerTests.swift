//
//  FoodListViewControllerTests.swift
//  FoodAppTests
//
//  Created by VenkateswaraReddy Nandipati on 21/07/22.
//

import UIKit
import XCTest
@testable import FoodApp

class FoodListViewControllerTests: XCTestCase {
    var sut: FoodListViewController?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
       sut = makeSUT()
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
        self.sut = nil
    }
}
