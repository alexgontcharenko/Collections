//
//  PhoneViewController.swift
//  CountriesTraveller
//
//  Created by Steew on 18.06.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit
import FlagPhoneNumber

class PhoneViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var finishButton: UIButton!
    
    let phoneNumberTextField = FPNTextField()
    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    var user = UserProfile()

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareList()
        prepareFinishButton()
    }
    
    func prepareView() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        phoneNumberTextField.delegate = self
        phoneNumberTextField.setFlag(key: .UA)
        phoneNumberTextField.set(phoneNumber: "000000000")
        view.addSubview(phoneNumberTextField)
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberTextField.centerYAnchor.constraint(equalTo: (self.view?.centerYAnchor)!).isActive = true
        phoneNumberTextField.centerXAnchor.constraint(equalTo: (self.view?.centerXAnchor)!).isActive = true
        phoneNumberTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func prepareFinishButton() {
        finishButton.setTitle(kFinishButtonTitle, for: .normal)
        finishButton.setTitleColor(UIColor.black, for: .normal)
        finishButton.layer.cornerRadius = 0.5 * finishButton.frame.size.width
        finishButton.clipsToBounds = true
        finishButton.backgroundColor = UIColor.lightText
        
        finishButton.addTarget(self, action: #selector(onTapFinishButton), for: .touchUpInside)
    }
    
    @objc func onTapFinishButton() {
        toSignInScreen()
    }
    
    func toSignInScreen() {
        let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        UIView.transition(with: window!, duration: 1, options: .transitionCurlDown, animations: {
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
        })
    }
    
    func prepareList() {
        phoneNumberTextField.displayMode = .list
        listController.setup(repository: phoneNumberTextField.countryRepository)
        listController.didSelect = { [weak self] country in
        self?.phoneNumberTextField.setFlag(countryCode: country.code)
        }
    }
    
}

extension PhoneViewController: FPNTextFieldDelegate {

   func fpnDisplayCountryList() {
      let navigationViewController = UINavigationController(rootViewController: listController)
      listController.title = "Countries"
      self.present(navigationViewController, animated: true, completion: nil)
   }

   func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        print(name, dialCode, code)
   }

   func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
            user.phone = textField.getFormattedPhoneNumber(format: .International)!
            print(user.phone)
            showAlert(title: "Phone number saved!", message: "")
      }
   }
}
