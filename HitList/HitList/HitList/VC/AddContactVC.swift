//
//  AddContactVC.swift
//  HitList
//
//  Created by Steew on 18.05.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit
import CoreData

protocol AddNewContact {
    func saveNewContact(name: String, surname: String, phone: String, adress: String, email: String)
}

class AddContactVC: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var adressField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var addContact: UIBarButtonItem!
    
    var delegate: AddNewContact?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//          return
//      }
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
//        do {
//        people = try managedContext.fetch(fetchRequest)
//      }
//        catch let error as NSError {
//        print("Could not fetch. \(error), \(error.userInfo)")
//      }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func newContact(_ sender: Any) {
        if let delegate = delegate {
            delegate.saveNewContact(name: nameField.text!, surname: surnameField.text!, phone: phoneField.text!, adress: adressField.text!, email: emailField.text!)
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notifName), object: nil)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
