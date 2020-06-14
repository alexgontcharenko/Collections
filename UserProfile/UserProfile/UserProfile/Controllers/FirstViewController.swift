//
//  ViewController.swift
//  UserProfile
//
//  Created by Steew on 12.06.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
    }

    func setupButton() {
        self.createButton.layer.cornerRadius = self.createButton.frame.height / 2
        self.createButton.backgroundColor = UIColor.orange
        self.createButton.clipsToBounds = true
        self.createButton.tintColor = UIColor.white
        self.createButton.setTitle("Create user", for: .normal)
    }

}

