//
//  ViewController.swift
//  TableViewCustom
//
//  Created by Steew on 07.05.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        myTableView.delegate = self
        myTableView.dataSource = self
        super.viewDidLoad()
        myTableView.register(UINib(nibName: String(describing: MyCell.self), bundle: nil), forCellReuseIdentifier: "MyCell")
        // Do any additional setup after loading the view.
    }
    
   
    //MARK: - UItableViewDelegate Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayOfMatches.count
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as! MyCell
        
        cell.firstImage.image = randomMatch(array: arrayOfMatches).image1
        cell.secondImage.image = randomMatch(array: arrayOfMatches).image2
        cell.cellLabel?.text = randomMatch(array: arrayOfMatches).score
        cell.timeLabel?.text = randomMatch(array: arrayOfMatches).time
        cell.cellLabel?.font = UIFont(name: "Helvetica Neue", size: 25)
        return cell
       }

}

