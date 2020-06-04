//
//  MainViewController.swift
//  FootballManager
//
//  Created by Steew on 03.06.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {
    @IBOutlet weak var teamsTableView: UITableView!
    
    var teams = [Team]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getTeamsRequest()
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
    
    func getTeamsRequest() {
        let headers = [
            "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
            "x-rapidapi-key": "499d366ab9mshbf8e9b29184ba1dp183b87jsn72eebb802141"
        ]
        let request = NSMutableURLRequest(url: NSURL(string: "https://api-football-v1.p.rapidapi.com/v2/teams/league/2")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        //var array = [Team]()
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                let httpResponse = response as? HTTPURLResponse
                //print(httpResponse as Any)
                guard let data = data else { return }
                let decoder = JSONDecoder()
                do {
                    let currentData = try decoder.decode(CurrentData.self, from: data)
                    self.teams = currentData.api.teams
                } catch {
                    print(error)
                }
                print(self.teams.count)
            }
        })
        dataTask.resume()
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
    
    
}
