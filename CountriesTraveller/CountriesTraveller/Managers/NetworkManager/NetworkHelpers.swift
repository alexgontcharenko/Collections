//
//  NetworkHelpers.swift
//  iTraveler
//
//  Created by Oleksandr Kurtsev on 18/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import Foundation
import Alamofire

enum HTTPMethod: String {
    case GET, POST, PUT, PATCH, DELETE
}

class NetworkHelpers {
    
    // MARK: - Properties
    
    static let shared = NetworkHelpers()
    private init() {}
    
    private let apiKey = "499d366ab9mshbf8e9b29184ba1dp183b87jsn72eebb802141"
    private let baseURL = ""
    
    // MARK: - Methods
    
    func getUrlFromString(stringURL: String) -> String {
        guard stringURL.contains("http") else { return baseURL + stringURL }
        return stringURL
    }
    
    func getHeaderWithAPIName() -> HTTPHeaders {
        let headers: HTTPHeaders = ["x-rapidapi-host": "restcountries-v1.p.rapidapi.com",
                                    "x-rapidapi-key" : apiKey]
        return headers
    }
    
    // MARK: - Helper methods for Parse
    
    func parseCountries(_ data: Data) -> Countries? {
        do {
            let countries = try JSONDecoder().decode(Countries.self, from: data)
            return countries
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func parseTranslatedText(_ data: Data) -> String? {
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                guard let text = json["translatedText"] as? String else { return nil }
                
                return text
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
