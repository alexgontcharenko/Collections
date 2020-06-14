//
//  ViewController.swift
//  NetworkManager
//
//  Created by Steew on 11.06.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    
    var team = Team()
    
    let session = URLSession.shared
    let apiStr = "https://api-football-v1.p.rapidapi.com/v2/teams/team/33"

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.sharedInstance.requestApi(serviceName: apiStr, method: .GET, postData: [:], withProgressHUD: false) { (any, error, errorType, response) in
            if let response = response {
                print(response)
            }
            if let error = error {
                print(error)
                print(errorType)
            }
            let json = JSON(any as Any)
            print(json)
            
            self.team.name = json["api"]["teams"]["name"].string!
            print(self.team.name)
            
        }
    }


}

