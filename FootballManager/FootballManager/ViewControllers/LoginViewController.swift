//
//  ViewController.swift
//  FootballManager
//
//  Created by Steew on 03.06.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import GoogleSignIn

class LoginViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var facebookButton: FBLoginButton!
    
    var handle: AuthStateDidChangeListenerHandle?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        facebookButton.delegate = self
        facebookButton.permissions = ["public_profile", "email"]
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }

    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    @IBAction func onLoginTap(_ sender: Any) {
        if let email = emailField.text, let password = passField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard self != nil else { return }
                if error != nil {
                    self!.showErrorAlert()
                } else {
                    self!.showSuccesAlert()
                }
            }
        }
    }
    
    func showSuccesAlert() {
        let alert = UIAlertController(title: "Success", message: "You are logged in", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
            self.onMainScreen()
        }))
        self.present(alert, animated: false, completion: nil)
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Warning! This user doesn't exist", message: "Check out your e-mail and password", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: false) {
        }
    }
    
    func onMainScreen() {
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "toMainSegue", sender: self)

        }
    }
}

extension LoginViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
          print(error.localizedDescription)
          return
        }
        guard result!.isCancelled == false else { return }
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first
            window?.rootViewController?.performSegue(withIdentifier: "toMainSegue", sender: nil)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Log Out")
    }
}

