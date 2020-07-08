//
//  InfoViewController.swift
//  Aztro
//
//  Created by Steew on 08.07.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        prepareBackButton()
    }
    
    func setBackground() {
        textLabel.minimumScaleFactor = 0.1
        let backgroundImageView = UIImageView()
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        backgroundImageView.image = UIImage(named: "background")
        view.sendSubviewToBack(backgroundImageView)
    }
    
    func prepareBackButton() {
        backButton.addTarget(self, action: #selector(onTapBackButton), for: .touchUpInside)
    }
    
    @objc func onTapBackButton() {
        dismiss(animated: false, completion: nil)
    }
    
}
