//
//  NetworkManager.swift
//  iTraveler
//
//  Created by Oleksandr Kurtsev on 17/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    // MARK: - Properties
    
    static let shared = NetworkManager()
    private let sharedNetworkHelpers = NetworkHelpers.shared
    private init() {}
    
    // MARK: - Methods
    
    func requestApi(stringURL: String, method: HTTPMethod, parameters: Parameters? = nil, completion: @escaping (Result<Data?, Error>) -> Void) {
        
        guard NetworkReachabilityManager()?.isReachable == true else {
            completion(.failure(NetworkError.noNetwork))
            return
        }
        
        let url = sharedNetworkHelpers.getUrlFromString(stringURL: stringURL)
        let headers = sharedNetworkHelpers.getHeaderWithAPIName()
        
        switch method {
            
        case .GET:
            
            AF.request(url, method: .get, parameters: parameters, headers: headers).responseJSON { (response) in
                switch response.result {
                case .success(_):
                    completion(.success(response.data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }

        case .POST:
            
            AF.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
                switch response.result {
                case .success(_):
                    completion(.success(response.data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
        case .PUT:
            
            AF.request(url, method: .put, parameters: parameters, headers: headers).responseJSON { (response) in
                switch response.result {
                case .success(_):
                    completion(.success(response.data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
        case .PATCH:
            
            AF.request(url, method: .patch, parameters: parameters, headers: headers).responseJSON { (response) in
                switch response.result {
                case .success(_):
                    completion(.success(response.data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
        case .DELETE:
            
            AF.request(url, method: .delete, parameters: parameters, headers: headers).responseJSON { (response) in
                switch response.result {
                case .success(_):
                    completion(.success(response.data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getVinDecode(vin: String, completion: @escaping (Result<Data?, Error>) -> Void) {
        let headers = [
            "x-rapidapi-host": "vindecoder.p.rapidapi.com",
            "x-rapidapi-key": "499d366ab9mshbf8e9b29184ba1dp183b87jsn72eebb802141"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://vindecoder.p.rapidapi.com/decode_vin?vin=\(vin)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                completion(.failure(error!))
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse as Any)
            }
            if let data = data {
                completion(.success(data))
            }
        })

        dataTask.resume()
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
