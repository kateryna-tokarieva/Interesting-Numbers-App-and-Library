//
//  FactDataDelegate.swift
//  InterestingNumbers
//
//  Created by Екатерина Токарева on 11/03/2023.
//

import Foundation
import InterestingNumbersLibrary

protocol FactDataDelegate: AnyObject {
    func didReceiveFacts(fact: NumberFact?, factsDictionary: [String: String]?)
}
