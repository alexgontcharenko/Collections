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
    var generator: MatchesGenerator?
    
    override func viewDidLoad() {
        myTableView.delegate = self
        myTableView.dataSource = self
        super.viewDidLoad()
        myTableView.register(UINib(nibName: String(describing: MyCell.self), bundle: nil), forCellReuseIdentifier: "MyCell")
        
        generator = MatchesGenerator.init(count: 30)
    }
    
   
    //MARK: - UItableViewDelegate Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (generator?.matchCount())!
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as! MyCell
        let match = generator?.getMatchByIndex(index: indexPath.row)
        
        cell.firstImage.image = match?.image1
        cell.secondImage.image = match?.image2
        cell.cellLabel?.text = match?.score
        cell.timeLabel?.text = match?.time
        cell.cellLabel?.font = UIFont(name: "Helvetica Neue", size: 25)
        
        
        return cell
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.size.height / 8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailsViewController = storyboard?.instantiateViewController(identifier: "DetailsViewController") as? DetailsViewController {
            detailsViewController.match = generator!.getMatchByIndex(index: indexPath.row)
            
            navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
    
}

