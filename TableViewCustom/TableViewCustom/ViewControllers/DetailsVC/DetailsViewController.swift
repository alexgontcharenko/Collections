//
//  DetailsViewController.swift
//  TableViewCustom
//
//  Created by Steew on 13.05.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var firstTeamImage: UIImageView!
    @IBOutlet weak var secondTeamImage: UIImageView!
    @IBOutlet weak var firstTeamName: UILabel!
    @IBOutlet weak var secondTeamName: UILabel!
    @IBOutlet weak var detailsTableView: UITableView!
    
    
    var match: Match?

    override func viewDidLoad() {
        super.viewDidLoad()
        detailsTableView.dataSource = self
        detailsTableView.delegate = self
        detailsLabel?.text = match?.score
        firstTeamImage.image = match?.image1
        secondTeamImage.image = match?.image2
        detailsLabel?.font = UIFont(name: "Helvetica Neue", size: 35)
        firstTeamName?.text = match?.nameOfFirstTeam
        secondTeamName?.text = match?.nameOfSecondTeam
        firstTeamName?.font = UIFont(name: "AmericanTypewriter", size: 17)
        secondTeamName?.font = UIFont(name: "AmericanTypewriter", size: 17)
        detailsTableView.register(UINib(nibName: String(describing: DetailsCell.self), bundle: nil), forCellReuseIdentifier: "DetailsCell")
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        firstTeamImage.isUserInteractionEnabled = true
        firstTeamImage.addGestureRecognizer(tapGestureRecognizer)
        let secondTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTappedTwo(tapGestureRecognizer:)))
        secondTeamImage.isUserInteractionEnabled = true
        secondTeamImage.addGestureRecognizer(secondTapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        _ = tapGestureRecognizer.view as! UIImageView
        
        if let playerViewController = storyboard?.instantiateViewController(identifier: "PlayersViewController") as? PlayersViewController {
            
            navigationController?.pushViewController(playerViewController, animated: true)
        }
    }
    
    @objc func imageTappedTwo(tapGestureRecognizer: UITapGestureRecognizer){
        _ = tapGestureRecognizer.view as! UIImageView
        
        if let playerViewController = storyboard?.instantiateViewController(identifier: "PlayersViewController") as? PlayersViewController {
            
            navigationController?.pushViewController(playerViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (match?.details.arrayOfNameDetails.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell") as! DetailsCell
        cell.detailName.text = match?.details.arrayOfNameDetails[indexPath.row]
        cell.firstTeamDetail?.text = match?.details.arrayOfDetailsOne[indexPath.row]
        cell.secondTeamDetail.text = match?.details.arrayOfDetailsTwo[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.size.height / 7
    }

}
