//
//  EnterVC.swift
//  HitList
//
//  Created by Steew on 23.05.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class EnterVC: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var enterLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterLable.text = "Enter login and password"
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
          // ...
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    @IBAction func onLoginButton(_ sender: Any) {
        if let email = emailField.text, let password = passField.text {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard self != nil else { return }
          // ...
        }
    }
        if Auth.auth().currentUser != nil {
          if let viewController = storyboard?.instantiateViewController(identifier: "ViewController") as? ViewController {
          navigationController?.pushViewController(viewController, animated: true)
        } else {
            enterLable.text = "No user found"
        }
    }
}

}
