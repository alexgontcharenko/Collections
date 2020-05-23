//
//  ViewController.swift
//  HitList
//
//  Created by Steew on 16.05.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit
import CoreData

let notifName = "updateData"
var people: [NSManagedObject] = []

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var contactsTableView: UITableView!
    @IBOutlet weak var addName: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        contactsTableView.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellReuseIdentifier: "Cell")
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name: NSNotification.Name(rawValue: notifName), object: nil)
    }
    
    @objc func updateData() {
        contactsTableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
      }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest =  NSFetchRequest<NSManagedObject>(entityName: "Person")
        do {
        people = try managedContext.fetch(fetchRequest)
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.contactsTableView.reloadData()
    }
    
    @IBAction func addName(_ sender: AnyObject) {
        if let addContactVC = storyboard?.instantiateViewController(identifier: "AddContactVC") as? AddContactVC {
        let navController = UINavigationController(rootViewController: addContactVC)
            addContactVC.delegate = self
        navigationController?.present(navController, animated: true, completion: nil)
        }
    }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return people.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let person = people[indexPath.row]
          let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
          cell.nameLabel?.text = person.value(forKeyPath: "name") as? String
          cell.surnameLabel?.text = person.value(forKey: "surname") as? String
          return cell
        }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          if let infoViewController = storyboard?.instantiateViewController(identifier: "InfoViewController") as? InfoViewController {
            infoViewController.contact = people[indexPath.row]
            
            navigationController?.pushViewController(infoViewController, animated: true)
        }
    }
}

extension ViewController: AddNewContact {
    func saveNewContact(name: String, surname: String, phone: String, adress: String, email: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
          else {
          return
        }
          let managedContext = appDelegate.persistentContainer.viewContext
          let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
          let person = NSManagedObject(entity: entity, insertInto: managedContext)
          person.setValue(name, forKeyPath: "name")
          person.setValue(surname, forKeyPath: "surname")
          person.setValue(phone, forKeyPath: "phone")
          person.setValue(adress, forKeyPath: "adress")
          person.setValue(email, forKeyPath: "email")
          do {
          try managedContext.save()
          people.append(person)
        }
          catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
}

