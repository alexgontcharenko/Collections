//
//  BaseViewController.swift
//  FootballManager
//
//  Created by Steew on 10.06.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func showValidAlert() {
        let alert = UIAlertController(title: "Password or Email is not valid", message: requiredField, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: false) {
        }
    }
    
    func showSuccesAlert() {
        let alert = UIAlertController(title: "Congratulations", message: successField, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
            self.onLoginScreen()
        }))
        self.present(alert, animated: false, completion: nil)
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Oops! User was not created", message: incorrectField, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: false) {
        }
    }
    
    func onLoginScreen() {
    dismiss(animated: true, completion: nil)
    }
    
    func getImage(from string: String) -> UIImage? {
        guard let url = URL(string: string) else { print("Unable to create URL"); return nil }
        var image: UIImage? = nil
        do {
            let data = try Data(contentsOf: url, options: [])
            image = UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
        }
        return image
    }
}
