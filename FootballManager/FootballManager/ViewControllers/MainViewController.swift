//
//  MainViewController.swift
//  FootballManager
//
//  Created by Steew on 03.06.2020.
//  Copyright © 2020 Steew. All rights reserved.
//


import UIKit
import Firebase

class MainViewController: BaseViewController {
    @IBOutlet weak var teamsTableView: UITableView!
    
    var networkManager = NetworkManager()
    var teams = [Team]()

    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.getTeamsRequest(url: API_TEAMS, retData: .teamsData)
        networkManager.onCompletion = { currentData in
            self.teams = currentData.api.teams
            DispatchQueue.main.async {
                self.teamsTableView.reloadData()
            }
        }
        teamsTableView.dataSource = self
        teamsTableView.delegate = self
        teamsTableView.register(UINib(nibName: String(describing: TeamsCell.self), bundle: nil), forCellReuseIdentifier: "TeamsCell")
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print("Error signing out: №,", signOutError)
            }
            let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first
            if window?.rootViewController is LoginViewController {
            dismiss(animated: true)
            } else {
                let vc = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController")
                window?.rootViewController = vc
                UIView.transition(with: window!, duration: 0.5, options: .transitionFlipFromRight, animations: {})
            }
        } else {
            print("auth error")
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamsCell") as! TeamsCell
        let team = teams[indexPath.row]
        cell.teamImage.image = getImage(from: team.logo)
        cell.teamNameLabel.text = team.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let team = teams[indexPath.row]
        let url = API_STATISTICS + String(team.teamID)
        networkManager.getTeamsRequest(url: url, retData: .statisticsData)
        
        let vc = storyboard?.instantiateViewController(identifier: "StatisticsViewController") as! StatisticsViewController
        present(vc, animated: true)
    }
    
}
