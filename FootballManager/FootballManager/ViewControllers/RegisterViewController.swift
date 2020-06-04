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

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var userLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onSaveButton(_ sender: Any) {
        if validPassword(myPassword: passField.text!) && validEmail(myEmail: emailField.text!) {
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
        
    func showValidAlert() {
        let alert = UIAlertController(title: "Password or Email is not valid", message: "Required at least one number, one uppercase, one lowercase, minimum 6 symbols in password", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: false) {
        self.userLabel.text = "Wrong password!"
        }
    }
    
    func onLoginScreen() {
        dismiss(animated: true, completion: nil)
        }
    
    func showSuccesAlert() {
        let alert = UIAlertController(title: "Congratulations", message: "Your user was created", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
            self.onLoginScreen()
        }))
        self.present(alert, animated: false, completion: nil)
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Oops! User was not created", message: "Try again with correct e-mail and password", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: false) {
        self.userLabel.text = "Fill in all the fields!"
        }
    }
}
