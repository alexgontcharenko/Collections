//
//  SecondViewController.swift
//  RWRC
//
//  Created by Steew on 25.06.2020.
//  Copyright © 2020 Razeware. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onTapLoginButton(_ sender: Any) {
        let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first
        let rootViewController = LoginViewController()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
  
}
