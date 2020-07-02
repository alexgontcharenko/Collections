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
    
    func getImagetoText(url: URL, completion: @escaping (Result<String, Error>) -> Void) {

        let headers = [
            "x-rapidapi-host": "image-to-text2.p.rapidapi.com",
            "x-rapidapi-key": "499d366ab9mshbf8e9b29184ba1dp183b87jsn72eebb802141",
            "content-type": "application/json",
            "accept": "application/json"
        ]
        let parameters = [
            "source": url.absoluteString,
            "sourceType": "url"
        ] as [String : Any]

        do {
            
            let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])

            let request = NSMutableURLRequest(url: NSURL(string: "https://image-to-text2.p.rapidapi.com/cloudVision/imageToText/")! as URL,
                                                    cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
            print(url.absoluteString)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = postData as Data

            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    //print(error)
                } else {
                    let httpResponse = response as? HTTPURLResponse
                    print(httpResponse as Any)
                }
                if let data = data {
                    let result = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    if let result = result {
                        let readyText = result["text"] as! String
                        completion(.success(readyText))
                    } else {
                        completion(.failure(error!))
                    }
                }
            })
            dataTask.resume()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getTranslatedText(text: String, completion: @escaping (Result<Data?, Error>) -> Void) {
        
        let headers = ["x-rapidapi-host": "language-translation.p.rapidapi.com",
                       "x-rapidapi-key": "499d366ab9mshbf8e9b29184ba1dp183b87jsn72eebb802141",
                       "content-type": "application/json",
                       "accept": "application/json"]
        
        let parameters = ["target": "fr",
                          "text": text,
                          "type": "plain"] as Parameters
        
        
        let data = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        guard let url = URL(string: "https://language-translation.p.rapidapi.com/translateLanguage/translate") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = data
        
        AF.request(request).responseJSON { (response) in
            switch response.result {
            case .success(_):
                completion(.success(response.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
