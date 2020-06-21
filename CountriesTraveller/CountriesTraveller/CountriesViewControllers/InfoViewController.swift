//
//  InfoViewController.swift
//  CountriesTraveller
//
//  Created by Steew on 21.06.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var country: Country!

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        prepareView()
        prepareBackButton()
    }
    
    func setBackground() {
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
    
    func prepareView() {
        navigationController?.navigationBar.isHidden = true
        nameLabel.text = country.name
        capitalLabel.text = country.capital
        populationLabel.text = String(describing: country.population)
        currencyLabel.text = country.currencies.first
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
