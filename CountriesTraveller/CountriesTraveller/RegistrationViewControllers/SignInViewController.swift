//
//  SignInViewController.swift
//  CountriesTraveller
//
//  Created by Steew on 20.06.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var registerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    func prepareView() {
        setBackground()
        prepareLoginButton()
        prepareRegisterButton()
        registerLabel.text = kRegisterLabel
        emailField.placeholder = kEnterEmail
        passField.placeholder = kEnterPassword
        passField.isSecureTextEntry = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapGesture))
        self.view.addGestureRecognizer(tapGesture)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setBackground() {
        let backgroundImageView = UIImageView()
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        backgroundImageView.image = UIImage(named: "launchBackground")
        view.sendSubviewToBack(backgroundImageView)
    }
    
    func prepareRegisterButton() {
        registerButton.setTitle(kRegisterButtonTitle, for: .normal)
        registerButton.addTarget(self, action: #selector(onTapRegisterButton), for: .touchUpInside)
    }
    
    @objc func onTapRegisterButton() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func prepareLoginButton() {
        loginButton.setTitle(kLoginButtonTitle, for: .normal)
        loginButton.setTitleColor(UIColor.black, for: .normal)
        loginButton.layer.cornerRadius = 0.5 * loginButton.frame.size.width
        loginButton.clipsToBounds = true
        loginButton.backgroundColor = UIColor.lightText
        
        loginButton.addTarget(self, action: #selector(onTapLoginButton), for: .touchUpInside)
    }
    
    @objc func onTapLoginButton() {
        if Validators.isValidEmail(emailField.text!) && Validators.isFilledTextFields(emailField.text!, passField.text!){
            loginAction()
        }
    }
    
    func loginAction() {
        AuthManager.shared.login(email: emailField.text!, password: passField.text!) { (result) in
            switch result {
            case .success:
                self.showAlert(title: kAlertTitleSuccess, message: kAlertMessageSuccess) {
                    self.onCountriesScreen()
                }
            case .failure:
                self.showAlert(title: kAlertTitleWrong, message: kAlertMessageNoUser)
            }
        }
    }
    
    func onCountriesScreen() {
        let storyboard = UIStoryboard(name: "Countries", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CountriesNavigationController")
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
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
