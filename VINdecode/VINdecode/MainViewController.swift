//
//  ViewController.swift
//  VINdecode
//
//  Created by Steew on 04.07.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {
    @IBOutlet weak var vinField: UITextField!
    @IBOutlet weak var decodeButton: UIButton!
    
    var car = Car()
    var specs: Specs?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        prepareDecodeButton()
    }
    
    func setBackground() {
        navigationController?.navigationBar.isHidden = true
        let backgroundImageView = UIImageView()
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        backgroundImageView.image = UIImage(named: "background")
        view.sendSubviewToBack(backgroundImageView)
    }
    
    func prepareDecodeButton() {
        decodeButton.addTarget(self, action: #selector(getCarInfo), for: .touchUpInside)
    }
    
    @objc func getCarInfo() {
        NetworkManager.shared.getVinDecode(vin: "4F2YU09161KM33122") { (result) in
            switch result {case .success(let data):
                guard let data = data else {return}
                print(String(data: data, encoding: .utf8)!)
                if let specsData = NetworkHelpers.shared.parseVin(data) {
                    self.specs = specsData
                }
            case .failure(let error):
                print(error.localizedDescription) 
            }
        }
    }
    
}

