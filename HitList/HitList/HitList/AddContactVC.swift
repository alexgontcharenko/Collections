//
//  AddContactVC.swift
//  HitList
//
//  Created by Steew on 18.05.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit
import CoreData

class DataManager {

        static let shared = DataManager()
        var firstVC = ViewController()
}

class AddContactVC: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var adressField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var addContact: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      //1
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
          return
      }
      
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      //2
      let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "Person")
      
      //3
      do {
        people = try managedContext.fetch(fetchRequest)
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func newContact(_ sender: Any) {
        self.savePerson(name: nameField.text!, surname: surnameField.text!, phone: phoneField.text!, adress: adressField.text!, email: emailField.text!)
        DataManager.shared.firstVC.contactsTableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
    func savePerson(name: String, surname: String, phone: String, adress: String, email: String) {
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      // 1
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      // 2
      let entity =
        NSEntityDescription.entity(forEntityName: "Person",
                                   in: managedContext)!
      
      let person = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      
      // 3
      person.setValue(name, forKeyPath: "name")
      person.setValue(surname, forKeyPath: "surname")
      person.setValue(phone, forKeyPath: "phone")
      person.setValue(adress, forKeyPath: "adress")
      person.setValue(email, forKeyPath: "email")
      
      // 4
      do {
        try managedContext.save()
        people.append(person)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
