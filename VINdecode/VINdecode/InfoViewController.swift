//
//  InfoViewController.swift
//  VINdecode
//
//  Created by Steew on 04.07.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var engineLabel: UILabel!
    @IBOutlet weak var madeInLabel: UILabel!
    @IBOutlet weak var standardSeatingsLabel: UILabel!
    @IBOutlet weak var cityMileageLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var vin = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        prepareBackButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        getCarInfo()
    }
    
    func prepareBackButton() {
        backButton.addTarget(self, action: #selector(onBackButton), for: .touchUpInside)
    }
    
    @objc func onBackButton() {
        let vc = self.storyboard?.instantiateViewController(identifier: "MainViewController") as! MainViewController
        self.vin = ""
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setBackground() {
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

    func getCarInfo() {
        NetworkManager.shared.getVinDecode(vin: vin) { (result) in
            switch result {case .success(let data):
                guard let data = data else {return}
                print(String(data: data, encoding: .utf8)!)
                
                let car = NetworkManager.shared.decodeJSON(type: Car.self, from: data)
                
                DispatchQueue.main.async {
                    self.yearLabel.text = car?.specification.year
                    self.makeLabel.text = car?.specification.make
                    self.modelLabel.text = car?.specification.model
                    self.engineLabel.text = car?.specification.engine
                    self.madeInLabel.text = car?.specification.madeIn
                    self.standardSeatingsLabel.text = car?.specification.standardSeating
                    self.cityMileageLabel.text = car?.specification.cityMileage
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
