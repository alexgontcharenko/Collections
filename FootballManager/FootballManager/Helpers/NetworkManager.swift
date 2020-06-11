//
//  File.swift
//  FootballManager
//
//  Created by Steew on 10.06.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import Foundation
import SwiftyJSON

enum ReturnData {
    case teamsData
    case statisticsData
}

class NetworkManager: NSObject {
    
    var onCompletion: ((CurrentData) -> Void)?
    
    var onCompletionStatistics: ((Statistics) -> Void)?
    
    func prepareHeaders () -> [String: String] {
        let headers = ["x-rapidapi-host": "api-football-v1.p.rapidapi.com",
                       "x-rapidapi-key": API_KEY]
        return headers
    }
    
    func getTeamsRequest(url: String, retData: ReturnData) {
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = prepareHeaders()
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if (error != nil) {
                print(error as Any)
            } else {
                //let httpResponse = response as? HTTPURLResponse
                //print(httpResponse as Any)
                guard let data = data else { return }
                let decoder = JSONDecoder()
                do {
                    if retData == .teamsData {
                        let currentData = try decoder.decode(CurrentData.self, from: data)
                        self.onCompletion?(currentData)
                    } else {
                        let json = try JSON(data: data)
                        let api: Dictionary<String, JSON> = json["api"].dictionaryValue
                        let stat: Dictionary<String, JSON> = api["statistics"]!.dictionaryValue
                        do {
                            let rawData = try stat.rawData()
                        } catch {
                            print("Error \(error)")
                        }
//                        let matches = stat["matchs"]?.dictionaryValue
//                        let matchesStat = try decoder.decode(Statistics.self, from: matches)
                    }
                    
                } catch {
                    print(error)
                }
            }
        })
        dataTask.resume()
    }
}
