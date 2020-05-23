//
//  FavouritesVC.swift
//  HitList
//
//  Created by Steew on 18.05.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit
import CoreData

class FavouritesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var favourites: [NSManagedObject] = [NSManagedObject]()
    
    @IBOutlet weak var favouritesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favouritesTableView.delegate = self
        favouritesTableView.dataSource = self
        favouritesTableView.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellReuseIdentifier: "Cell")
        favouritesTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else {
        return
    }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        do {
            people = try managedContext.fetch(fetchRequest)
    }   catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
        favouritesTableView.reloadData()
    }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if favourites.count > 0 {
                return favourites.count
            }
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if favourites.count > 0 {
        let person = favourites[indexPath.row]
        let cell = favouritesTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        cell.nameLabel?.text = person.value(forKeyPath: "name") as? String
        cell.surnameLabel?.text = person.value(forKey: "surname") as? String
        return cell
        }
        return UITableViewCell()
    }
}
