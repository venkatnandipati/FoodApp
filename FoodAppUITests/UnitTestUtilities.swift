//
//  UnitTestUtilities.swift
//  FoosApp
//
//  Created by VenkateswaraReddy Nandipati on 11/07/22.
//

import Foundation
import XCTest
class UnitTestUtilities: XCTestCase {
    func getLaunchArguement() -> String {
        return "TestCasesExecution"
    }
    func waitForElement(element: XCUIElement, toShow: Bool, needToTap: Bool, assertMessage: String? = nil) {
        let exists = NSPredicate(format: "exists == \(toShow)")
        var assertMsg = ""
        if let msg = assertMessage {
            assertMsg = msg
        } else {
            if toShow {
                assertMsg = "element appeared"
            } else {
                assertMsg = "element doesn't appeared"
            }
        }
        waitWithPredicate(predicate: exists, forElement: element, needToTap: needToTap, assertMessage: assertMsg)
    }
    func waitWithPredicate(predicate: NSPredicate, forElement: XCUIElement, needToTap: Bool, assertMessage: String) {
        expectation(for: predicate, evaluatedWith: forElement) { () -> Bool in
            if needToTap == true {
                forElement.tap()
            }
            XCTAssertEqual(1, 1, assertMessage)
            return true
        }
        waitForExpectations(timeout: 90, handler: nil)
    }
}
