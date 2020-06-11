//
//  RegisterViewController.swift
//  FootballManager
//
//  Created by Steew on 03.06.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: BaseViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var confirmPassField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var userLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onSaveButton(_ sender: Any) {
        if validPassword(myPassword: passField.text!) && validEmail(myEmail: emailField.text!) && passField.text! == confirmPassField.text! {
            Auth.auth().createUser(withEmail: emailField.text!, password: passField.text!) { authResult, error in
                if error != nil {
                    self.showErrorAlert()
                } else {
                    self.showSuccesAlert()
                }
            }
        } else {
            showValidAlert()
        }
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
        
    func validEmail(myEmail : String) -> Bool {

        let emailReg =  ("[A-Z0-9a-z._%+_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        let emailTesting = NSPredicate(format: "SELF MATCHES %@", emailReg)
        return emailTesting.evaluate(with: myEmail)
    }
           
    func validPassword(myPassword : String) -> Bool {

        let passwordReg =  ("(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,}")
        let passwordTesting = NSPredicate(format: "SELF MATCHES %@", passwordReg)
        return passwordTesting.evaluate(with: myPassword)
    }
}
