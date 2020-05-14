//
//  PlayersViewController.swift
//  TableViewCustom
//
//  Created by Steew on 14.05.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit

class PlayersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var generator: MatchesGenerator?

    @IBOutlet weak var playerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerTableView.delegate = self
        playerTableView.dataSource = self
        playerTableView.register(UINib(nibName: String(describing: PlayerCell.self), bundle: nil), forCellReuseIdentifier: "PlayerCell")
        generator = MatchesGenerator.init(count: 30)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
        let match = generator?.getMatchByIndex(index: indexPath.row)
        
        cell.playerName.text = match?.players.playerName
        cell.playerImage.image = match?.players.playerImg
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.size.height / 8
    }
}
