//
//  ViewController.swift
//  HitList
//
//  Created by Steew on 16.05.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var contactsTableView: UITableView!
    @IBOutlet weak var addName: UIBarButtonItem!
    var people: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        contactsTableView.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
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
    
    @IBAction func addName(_ sender: AnyObject) {
      let newAlert = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: UIAlertController.Style.alert)
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            let nameToSave = newAlert.textFields![0].text
            let surnameToSave = newAlert.textFields![1].text
            let phoneToSave = newAlert.textFields![2].text
            let adressToSave = newAlert.textFields![3].text
            let emailToSave = newAlert.textFields![4].text
            
            self.savePerson(name: nameToSave!, surname: surnameToSave!, phone: phoneToSave!, adress: adressToSave!, email: emailToSave!)
            self.contactsTableView.reloadData()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
        (action : UIAlertAction!) -> Void in })
      newAlert.addTextField { (textField : UITextField!) -> Void in
      textField.placeholder = "Enter Name"
      }
      newAlert.addTextField { (textField : UITextField!) -> Void in
      textField.placeholder = "Enter Surname"
      }
      newAlert.addTextField { (textField : UITextField!) -> Void in
          textField.placeholder = "Enter Phone"
      }
      newAlert.addTextField { (textField : UITextField!) -> Void in
          textField.placeholder = "Enter Adress"
      }
      newAlert.addTextField { (textField : UITextField!) -> Void in
          textField.placeholder = "Enter Email"
      }
      newAlert.addAction(saveAction)
      newAlert.addAction(cancelAction)

      self.present(newAlert, animated: true, completion: nil)
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
        
        func tableView(_ tableView: UITableView,
                       numberOfRowsInSection section: Int) -> Int {
            return people.count
        }

        func tableView(_ tableView: UITableView,
                       cellForRowAt indexPath: IndexPath)
                       -> UITableViewCell {

          let person = people[indexPath.row]
          let cell =
            tableView.dequeueReusableCell(withIdentifier: "Cell",
                                          for: indexPath) as! Cell
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
