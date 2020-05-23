//
//  LoginVC.swift
//  HitList
//
//  Created by Steew on 23.05.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func onRegisterAction(_ sender: Any) {
        if let registerVC = storyboard?.instantiateViewController(identifier: "RegisterVC") as? RegisterVC {
            let navController = UINavigationController(rootViewController: registerVC)
            navigationController?.present(navController, animated: true, completion: nil)
            }
        }
    @IBAction func onLoginAction(_ sender: Any) {
        if let enterVC = storyboard?.instantiateViewController(identifier: "EnterVC") as? EnterVC {
        navigationController?.pushViewController(enterVC, animated: true)
    }
    }
}
