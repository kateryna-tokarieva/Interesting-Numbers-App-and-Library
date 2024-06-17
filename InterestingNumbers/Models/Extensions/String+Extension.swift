//
//  String+Extension.swift
//  InterestingNumbers
//
//  Created by Екатерина Токарева on 11/03/2023.
//

import Foundation

extension String {
    func masked(option: FactOption) -> String? {
        var result = self
        switch option {
        case.userNumber:
            let set = Set("1234567890-")
            guard let last = self.last else { return result }
            if set.contains(last) {
                return result
            }
            result.removeLast()
            return result
        case .randomNumber:
            return nil
        case .numberInRange:
            let set = Set("1234567890.-…")
            guard let last = result.last else { return result }
            if set.contains(last) {
                return result
            }
            result.removeLast()
            return result
        case .multipleNumbers:
            let set = Set("1234567890,-")
            guard let last = result.last else { return result }
            if result == "," {
                return ""
            }
            if set.contains(last) {
                return result
            }
            result.removeLast()
            return result
        }
    }
    
    func isValidSearchRequest(option: FactOption) -> Bool {
        switch option {
        case.userNumber:
            for character in self {
                if !character.isNumber && character != "-" {
                    return false
                }
            }
            return true
        case .randomNumber:
            return self == "random"
        case .numberInRange:
            for character in self {
                if !character.isNumber && character != "." && character != "-" && character != "…"{
                    return false
                }
            }
            if self.first == "." || self.last == "." {
                return false
            }
            guard let first = self.components(separatedBy: "..").first,
            let last = self.components(separatedBy: "..").last,
            let firstInt = Int(first),
            let lastInt = Int(last) else { return false }
            if  firstInt >= lastInt {
                return false
            }
            return true
        case .multipleNumbers:
            for character in self {
                if !character.isNumber && character != "," && character != "-" {
                    return false
                }
            }
            if self.first == "," || self.last == "," {
                return false
            }
            return true
        }
    }
    
    var corrected: String {
        var text = self
        while text.last == "," || text.last == "." || text.last == "-" {
            text.removeLast()
        }
        
        if text.contains(".") && text.contains("…") {
            guard let first = self.components(separatedBy: "…").first,
                  let last = self.components(separatedBy: ".").last else { return text }
            text = first + ".." + last
        } else if text.contains(".") {
            guard let first = self.components(separatedBy: ".").first,
                  let last = self.components(separatedBy: ".").last else { return text }
            text = first + ".." + last
        } else if text.contains("…") {
            guard let first = self.components(separatedBy: "…").first,
                  let last = self.components(separatedBy: "…").last else { return text }
            text = first + ".." + last
        }
        return text
    }
}
