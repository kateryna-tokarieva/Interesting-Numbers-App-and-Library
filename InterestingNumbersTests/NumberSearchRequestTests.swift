//
//  NumberSearchRequestTests.swift
//  InterestingNumbersTests
//
//  Created by Екатерина Токарева on 31/03/2023.
//

import XCTest
@testable import InterestingNumbers

final class NumberSearchRequestTests: XCTestCase {
    func testIsValidRequestWithValidUserNumber() {
        let text = "1"
        XCTAssertTrue(text.isValidSearchRequest(option: .userNumber))
    }
    
    func testIsValidRequestWithNotValidUserNumber() {
        let text = "1a"
        XCTAssertFalse(text.isValidSearchRequest(option: .userNumber))
    }
    
    func testIsValidRequestWithValidRandomNumber() {
        let text = "random"
        XCTAssertTrue(text.isValidSearchRequest(option: .randomNumber))
    }
    
    func testIsValidRequestWithNotValidRandomNumber() {
        let text = "1"
        XCTAssertFalse(text.isValidSearchRequest(option: .randomNumber))
    }
    
    func testIsValidRequestWithValidNumberRange() {
        let text = "1..3"
        XCTAssertTrue(text.isValidSearchRequest(option: .numberInRange))
    }
    
    func testIsValidRequestWithNotValidNumberRange() {
        let text = "1…3…"
        XCTAssertFalse(text.isValidSearchRequest(option: .numberInRange))
    }
    
    func testIsValidRequestWithValidMultipleNumber() {
        let text = "1,2,3"
        XCTAssertTrue(text.isValidSearchRequest(option: .multipleNumbers))
    }
    
    func testIsValidRequestWithNotValidMultipleNumber() {
        let text = "1,2,3,,"
        XCTAssertFalse(text.isValidSearchRequest(option: .multipleNumbers))
    }
}
