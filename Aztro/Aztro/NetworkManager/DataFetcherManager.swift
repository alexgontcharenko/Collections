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
    
    func fetchVideo(completion: @escaping ([Match]?) -> Void) {
        let urlString = "https://free-football-soccer-videos1.p.rapidapi.com/v1/"
        let headers = ["x-rapidapi-host" : "free-football-soccer-videos1.p.rapidapi.com",
                        "x-rapidapi-key"  : "499d366ab9mshbf8e9b29184ba1dp183b87jsn72eebb802141"]
        
        dataFetcher.fetchJSONData(urlString: urlString, headers: headers, response: completion)
    }
}
