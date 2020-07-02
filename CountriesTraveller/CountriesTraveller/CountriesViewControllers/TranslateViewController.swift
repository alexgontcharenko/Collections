//
//  TranslateViewController.swift
//  CountriesTraveller
//
//  Created by Steew on 01.07.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit
import Alamofire

class TranslateViewController: UIViewController {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var someText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.text = ""
    }
    
    func getTranslatedText() {
        NetworkManager.shared.getTranslatedText(text: someText!) { (result) in
            switch result {
                
            case .success(let data):
                guard let data = data else { return }
                guard let text = NetworkHelpers.shared.parseTranslatedText(data) else { return }
                
                DispatchQueue.main.async {
                    self.textLabel.text = text
                    print(text)
                }
                
            case .failure(let error):
                self.showAlert(title: kAlertTitleWrong, message: error.localizedDescription)
            }
        }
    }
    
}
