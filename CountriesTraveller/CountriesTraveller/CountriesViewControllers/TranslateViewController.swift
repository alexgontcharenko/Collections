//
//  TranslateViewController.swift
//  CountriesTraveller
//
//  Created by Steew on 01.07.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var someText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        prepareLabel()
        prepareBackButton()
    }
    
    func setBackground() {
        navigationController?.navigationBar.isHidden = true
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
    
    func prepareLabel() {
        textLabel.minimumScaleFactor = 0.1
        textLabel.text = someText
    }
    
    func prepareBackButton() {
        backButton.setTitle(kBackButtonTitle, for: .normal)
        backButton.setTitleColor(UIColor.black, for: .normal)
        backButton.layer.cornerRadius = 0.5 * backButton.frame.size.width
        backButton.clipsToBounds = true
        backButton.backgroundColor = UIColor.lightText
        
        backButton.addTarget(self, action: #selector(onBackButton), for: .touchUpInside)
    }
    
    @objc func onBackButton() {
        let storyboard = UIStoryboard(name: "Countries", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CountriesNavigationController")
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
}
