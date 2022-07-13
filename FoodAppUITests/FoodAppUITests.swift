//
//  FoodAppUITests.swift
//  FoodAppUITests
//
//  Created by VenkateswaraReddy Nandipati on 12/07/22.
//

import XCTest
import FoodApp

class FoodAppUITests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMovieListNotLoaded() {
        let app = XCUIApplication()
        let tableCell = app.tables.children(matching: .cell).element(boundBy: 0).staticTexts["FoodNameLabel"]
        XCTAssertFalse(tableCell.exists, "Table list not loaded")
    }
    func testGetfoodItemlist() {
        waitForFoodItemList()
    }
    func testShouldDisplaynavigationBarsTitle() {
        let app = XCUIApplication()
        let navigation = app.navigationBars.staticTexts["Nutriention Items"]
        XCTAssertTrue(navigation.exists, "navigation title shown")
    }
    func testToShowfoodItemDetail() {
        waitForFoodItemList()
        let app = XCUIApplication()
        app.tables.cells.containing(.staticText, identifier: "rank: 600").staticTexts["FoodNameLabel"].tap()
        let nameLabel = app.scrollViews.otherElements.staticTexts["Ingredients Label"]
        XCTAssertTrue(nameLabel.exists, "detail screen shown")
    }
    private func waitForFoodItemList() {
        let app = XCUIApplication()
        let foodCell = app.tables.children(matching: .cell).element(boundBy: 0).staticTexts["FoodNameLabel"]
        UnitTestUtilities().waitForElement(element: foodCell, toShow: true, needToTap: false, assertMessage: nil)
    }
}
