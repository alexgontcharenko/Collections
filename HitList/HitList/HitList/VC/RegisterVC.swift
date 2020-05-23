//
//  RegisterVC.swift
//  HitList
//
//  Created by Steew on 23.05.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit
import CoreData
import FirebaseAuth

class RegisterVC: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var userLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userLabel.text = "Create a new user"
    }
    @IBAction func onCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
}
    @IBAction func onSaveButton(_ sender: Any) {
        if emailField.text != "" && passField.text != "" {
        Auth.auth().createUser(withEmail: emailField.text!, password: passField.text!) { authResult, error in
            // ...
        }
            self.dismiss(animated: true, completion: nil)
        } else {
            userLabel.text = "Fill in all the fields!"
        }
        
    }
}
