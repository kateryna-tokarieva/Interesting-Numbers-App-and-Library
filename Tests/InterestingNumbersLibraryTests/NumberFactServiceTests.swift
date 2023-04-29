//
//  NumberFactServiceTests.swift
//  InterestingNumbersTests
//
//  Created by Екатерина Токарева on 30/03/2023.
//

import XCTest
@testable import InterestingNumbersLibrary

final class NumberFactServiceTests: XCTestCase {
    private var result: NumbersFactService.FetchResult?
    private let session = URLSessionMock()
    private lazy var numberFactServiceService = NumbersFactService(session: session)
    private let number = "1"
    
    func testSuccessfulServiceResponse() {
        let data = loadJSONData(fromFile: "validData")
        session.data = data
        guard let data = data else { return XCTFail() }
        guard let parsedData = numberFactServiceService.parseJSONAsNumberFact(withData: data) else { return XCTFail() }
        let comparingResult: NumbersFactService.FetchResult? =  NumbersFactService.FetchResult.success(parsedData)
        numberFactServiceService.fetchFacts(number: number, completionHandler: { self.result = $0 })
        XCTAssertEqual(result, comparingResult)
    }
    
    func testBrokenResponse() {
        let data = loadJSONData(fromFile: "notValidData")
        session.data = data
        let comparingResult = NumbersFactService.FetchResult.failure(NSError(domain: "ParsingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse JSON"]))
        numberFactServiceService.fetchFacts(number: number, completionHandler: { self.result = $0 })
        XCTAssertEqual(result, comparingResult)
    }
    
    // MARK: - Private
    
    private func loadJSONData(fromFile fileName: String) -> Data? {
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "validData", ofType: "json") else {
            XCTFail("Error finding JSON file: \(fileName)")
            return nil
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            return data
        } catch {
            XCTFail("Error loading JSON data: \(error.localizedDescription)")
            return nil
        }
    }
}
