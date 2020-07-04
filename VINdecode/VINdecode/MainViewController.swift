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
        decodeButton.layer.cornerRadius = 0.5 * decodeButton.frame.size.width
        decodeButton.clipsToBounds = true
        decodeButton.backgroundColor = .clear
        decodeButton.addTarget(self, action: #selector(onNextScreen), for: .touchUpInside)
    }
    
    @objc func onNextScreen() {
        if isValidNameField(text: vinField.text!) {
            let vc = self.storyboard?.instantiateViewController(identifier: "InfoViewController") as! InfoViewController
            vc.vin = vinField.text!
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            showAlert(title: "Warning", message: "VIN code is wrong")
        }
    }
    
}

