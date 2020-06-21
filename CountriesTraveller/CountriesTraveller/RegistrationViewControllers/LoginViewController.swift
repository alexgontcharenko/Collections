//
//  ViewController.swift
//  CountriesTraveller
//
//  Created by Steew on 14.06.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var confirmPassField: UITextField!
    
    var user = UserProfile()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareNextButton()
        prepareBackButton()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewDidLayoutSubviews()
    }
    
    func prepareView() {
        startLabel.text = kStartLabel
        firstNameField.placeholder = kEnterFirstName
        lastNameField.placeholder = kEnterLastName
        emailField.placeholder = kEnterEmail
        passField.placeholder = kPasswordField
        passField.isSecureTextEntry = true
        confirmPassField.placeholder = kConfirmPasswordField
        confirmPassField.isSecureTextEntry = true
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapGesture))
        self.view.addGestureRecognizer(tapGesture)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func prepareBackButton() {
        backButton.setTitle(kBackButtonTitle, for: .normal)
        backButton.setTitleColor(UIColor.black, for: .normal)
        backButton.layer.cornerRadius = 0.5 * backButton.frame.size.width
        backButton.clipsToBounds = true
        backButton.backgroundColor = UIColor.lightText
        
        backButton.addTarget(self, action: #selector(onTapBackButton), for: .touchUpInside)
    }
    
    @objc func onTapBackButton() {
        self.dismiss(animated: true)
    }
    
    func prepareNextButton() {
        nextButton.setTitle(kNextButtonTitle, for: .normal)
        nextButton.setTitleColor(UIColor.black, for: .normal)
        nextButton.layer.cornerRadius = 0.5 * nextButton.frame.size.width
        nextButton.clipsToBounds = true
        nextButton.backgroundColor = UIColor.lightText
        
        nextButton.addTarget(self, action: #selector(onTapButtonNext), for: .touchUpInside)
    }
    
    @objc func onTapButtonNext() {
        if Validators.isValidNameField(name: firstNameField.text!) && Validators.isValidNameField(name: lastNameField.text!) &&
            Validators.isValidEmail(emailField.text) && Validators.isPasswordsMatched(passField.text!, confirmPassField.text!) && Validators.isValidPassword(myPassword: passField.text!) {
            user.firstName = firstNameField.text!
            user.lastName = lastNameField.text!
            user.email = emailField.text!
            user.password = passField.text!
            saveUser()
            onSecondScreen()
        } else {
            self.showAlert(title: kAlertTitleWrong, message: kAlertMessageWrong)
        }
    }
    
    func saveUser() {
        AuthManager.shared.register(email: emailField.text, password: passField.text, confirmPassword: confirmPassField.text) { (result) in
            switch result {
            case .success:
                print(result)
            case .failure:
                self.showAlert(title: kAlertTitleWrong, message: kAlertMessageWrong)
                break
            }
        }
    }
    
    func onSecondScreen() {
        if let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DateViewController") as? DateViewController{
            vc.user = user
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func onTapGesture() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

}

