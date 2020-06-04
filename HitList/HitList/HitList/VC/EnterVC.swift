//
//  EnterVC.swift
//  HitList
//
//  Created by Steew on 23.05.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth
import FBSDKLoginKit

class EnterVC: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var enterLable: UILabel!
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onPrepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    func onPrepareView() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        enterLable.text = "Enter login and password"
        let loginButton = FBLoginButton()
        //loginButton.delegate = self
        onCheckSignInUser()
//        let loginButton = FBLoginButton()
//        loginButton.permissions = ["public_profile", "email"]
//        view.addSubview(loginButton)
//        if let token = AccessToken.current, !token.isExpired {} // User is logged in, do work such as go to next view controller.
//        
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
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
    
    func onContacts() {
        if Auth.auth().currentUser != nil {
            if let viewController = storyboard?.instantiateViewController(identifier: "ViewController") as? ViewController {
            navigationController?.pushViewController(viewController, animated: true)
            } else {
                enterLable.text = "No user found"
            }
        }
    }

    //logout method
    func onCheckSignInUser() {
        if Auth.auth().currentUser != nil {
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print("Error signing out: №,", signOutError)
            }
        } else {

        }
    }
    
    func showSuccesAlert() {
        let alert = UIAlertController(title: "Success", message: "You are logged in", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
            self.onContacts()
        }))
        self.present(alert, animated: false, completion: nil)
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Warning! This user doesn't exist", message: "Check out your e-mail and password", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: false) {
        }
    }
    
//    func loginButton(_ loginButton: FBLoginButton!, didCompleteWith result: LoginManagerLoginResult!, error: Error!) {
//      if let error = error {
//        print(error.localizedDescription)
//        return
//      }
//      // ...
//    }
}
