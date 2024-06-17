//
//  InterestingNumbersUITests.swift
//  InterestingNumbersUITests
//
//  Created by Екатерина Токарева on 10/03/2023.
//

import XCTest

final class InterestingNumbersUITests: XCTestCase {
    private var app: XCUIApplication!
    private lazy var userNumberButton = app.buttons["User number"]
    private lazy var randomNumberButton = app.buttons["Random number"]
    private lazy var numberInRangeButton = app.buttons["Numbers in a range"]
    private lazy var multipleNumbersButton = app.buttons["Multiple numbers"]
    private lazy var textField = app.textFields["TEXT_FIELD"]
    private lazy var displayFactButton = app.buttons["Display Fact"]
    private lazy var closeButton = app.buttons["X Circle"]
    private lazy var scrollViewElement = app.scrollViews.children(matching: .other).element.children(matching: .other).element
    
    override func setUp() {
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }
    
    func testUserNumber() {
        userNumberButton.tap()
        textField.tap()
        textField.typeText("1")
        app/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".keyboards",".buttons[\"done\"]",".buttons[\"Done\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        displayFactButton.tap()
        closeButton.tap()
    }
    
    func testRandomNumber() {
        randomNumberButton.tap()
        displayFactButton.tap()
        closeButton.tap()
    }
    
    func testNumberRange() {
        numberInRangeButton.tap()
        textField.tap()
        textField.typeText("1..5")
        app/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".keyboards",".buttons[\"done\"]",".buttons[\"Done\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        displayFactButton.tap()
        scrollViewElement.swipeLeft()
        scrollViewElement.swipeLeft()
        scrollViewElement.swipeLeft()
        scrollViewElement.swipeLeft()
        closeButton.tap()
    }
    
    func testMultipleNumber() {
        multipleNumbersButton.tap()
        textField.tap()
        textField.typeText("1,2,3")
        app/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".keyboards",".buttons[\"done\"]",".buttons[\"Done\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        displayFactButton.tap()
        scrollViewElement.swipeLeft()
        scrollViewElement.swipeLeft()
        closeButton.tap()
    }
}
