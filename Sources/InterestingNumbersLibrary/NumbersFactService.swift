//
//  NetworkService.swift
//  InterestingNumbers
//
//  Created by Екатерина Токарева on 10/03/2023.
//

import Foundation

public final class NumbersFactService {
    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    enum FetchResult {
        case success(NumberFact)
        case dictionary([String: String])
        case failure(Error)
    }

    func fetchFacts(number: String, completionHandler: @escaping (FetchResult) -> Void) {
        let url = self.searchURL(for: number)
        performRequest(withURL: url) { result in
            switch result {
            case .success(let fact):
                completionHandler(.success(fact))
            case .dictionary(let dict):
                completionHandler(.dictionary(dict))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    private func performRequest(withURL url: URL?, completionHandler: @escaping (FetchResult) -> Void) {
        guard let url = url else { return }
        session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let numberFact = self.parseJSONAsNumberFact(withData: data) {
                    completionHandler(.success(numberFact))
                } else if let dict = self.parseJSONAsDictionary(withData: data) {
                    completionHandler(.dictionary(dict))
                } else {
                    let error = NSError(domain: "ParsingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse JSON"])
                    completionHandler(.failure(error))
                }
            } else if let error = error {
                completionHandler(.failure(error))
            } else {
                let error = NSError(domain: "UnknownError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error occurred"])
                completionHandler(.failure(error))
            }
        }.resume()
    }

    func parseJSONAsNumberFact(withData data: Data) -> NumberFact? {
        let decoder = JSONDecoder()
        var numberFact: NumberFact?
        do {
            numberFact = try decoder.decode(NumberFact.self, from: data)
        } catch let error {
            print(error.localizedDescription)
        }
        return numberFact
    }

    private func parseJSONAsDictionary(withData data: Data) -> [String:String]? {
        var dictionary: [String:String]?
        do {
            dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:String]
        } catch let error {
            print(error.localizedDescription)
        }
        return dictionary
    }

    private func searchURL(for number: String) -> URL? {
        let urlString = API.baseURL + number
        var components = URLComponents(string: urlString)
        components?.query = "json"
        return components?.url
    }
}
