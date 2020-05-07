//
//  ViewController.swift
//  TableView Programmatically
//
//  Created by Steew on 07.05.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
  let tableView = UITableView()
  var safeArea: UILayoutGuide!
    
    var characters = ["Link", "Zelda", "Ganondorf", "Midna"]
    
  override func loadView() {
    super.loadView()
    view.backgroundColor = .white
    safeArea = view.layoutMarginsGuide
    setupTableView()
  }
    
  func setupTableView() {
    view.addSubview(tableView)
  tableView.translatesAutoresizingMaskIntoConstraints = false
  tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
  tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
  tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return characters.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = characters[indexPath.row]
    return cell
  }
}
