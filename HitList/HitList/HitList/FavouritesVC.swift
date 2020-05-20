//
//  FavouritesVC.swift
//  HitList
//
//  Created by Steew on 18.05.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit
import CoreData

class DataShare{
    static let shared = DataShare()
    var favVC = FavouritesVC()
}

class FavouritesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var favourites: [NSManagedObject]?
    
    @IBOutlet weak var favouritesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favouritesTableView.delegate = self
        favouritesTableView.dataSource = self
        favouritesTableView.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellReuseIdentifier: "Cell")
        self.favouritesTableView.reloadData()
        DataShare.shared.favVC = self
        // Do any additional setup after loading the view.
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = favourites?[indexPath.row]
        let cell = favouritesTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        cell.nameLabel?.text = person?.value(forKeyPath: "name") as? String
        cell.surnameLabel?.text = person?.value(forKey: "surname") as? String
        
        return cell
    }
}
