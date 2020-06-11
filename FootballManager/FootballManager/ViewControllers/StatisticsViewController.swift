//
//  StatisticsViewController.swift
//  FootballManager
//
//  Created by Steew on 11.06.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    @IBOutlet weak var allMatchesH: UILabel!
    @IBOutlet weak var allMatchesG: UILabel!
    @IBOutlet weak var allMatchesT: UILabel!
    
    @IBOutlet weak var winsH: UILabel!
    @IBOutlet weak var winsG: UILabel!
    @IBOutlet weak var winsT: UILabel!
    
    @IBOutlet weak var drawsH: UILabel!
    @IBOutlet weak var drawsG: UILabel!
    @IBOutlet weak var drawsT: UILabel!
    
    @IBOutlet weak var losesH: UILabel!
    @IBOutlet weak var losesG: UILabel!
    @IBOutlet weak var losesT: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        networkManager.onCompletionStatistics = { currentStat in
//            DispatchQueue.main.async {
//                self.allMatchesH.text! = String(currentStat.statistics.matchs.matchsPlayed.home)
//            }
//        }
    }
    
    @IBAction func onBackButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
