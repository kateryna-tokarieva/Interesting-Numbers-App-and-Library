//
//  FetchResult+Extension.swift
//  InterestingNumbersTests
//
//  Created by Екатерина Токарева on 31/03/2023.
//

import Foundation
@testable import InterestingNumbers
import InterestingNumbersLibrary

extension NumbersFactService.FetchResult: Equatable {
    public static func == (lhs: NumbersFactService.FetchResult, rhs: NumbersFactService.FetchResult) -> Bool {
        switch (lhs, rhs) {
        case let (.success(leftValue), .success(rightValue)):
            return leftValue == rightValue
        case let (.dictionary(leftValue), .dictionary(rightValue)):
            return leftValue == rightValue
        case let (.failure(leftValue), .failure(rightValue)):
            return "\(leftValue)" == "\(rightValue)"
        default:
            return false
        }
    }
}
