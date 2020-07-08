//
//  DataFetcherManager.swift
//  iWeather
//
//  Created by Oleksandr Kurtsev on 03/07/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import Foundation

class DataFetcherManager {
    
    var dataFetcher: DataFetcher

    init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.dataFetcher = dataFetcher
    }
    
    func fetchAztro(sign: String, completion: @escaping (Aztro?) -> Void) {
        let urlString = "https://sameer-kumar-aztro-v1.p.rapidapi.com/?sign=\(sign)&day=today"
        let headers = ["x-rapidapi-host" : "sameer-kumar-aztro-v1.p.rapidapi.com",
                        "x-rapidapi-key"  : "499d366ab9mshbf8e9b29184ba1dp183b87jsn72eebb802141",
                        "content-type" : "application/x-www-form-urlencoded"]
        
        dataFetcher.fetchJSONData(urlString: urlString, headers: headers, response: completion)
    }
}
