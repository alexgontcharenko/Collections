//
//  ViewController.swift
//  Aztro
//
//  Created by Steew on 06.07.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var aztroCollection: UICollectionView!
    
    var dataFetcher = DataFetcherManager()
    let aztroArray = ["aquarius", "aries", "cancer", "capricorn", "gemini", "leo", "libra", "pisces", "sagittarius", "scorpio", "taurus", "virgo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        aztroCollection.delegate = self
        aztroCollection.dataSource = self
        aztroCollection.register(UINib(nibName: String(describing: AztroCell.self), bundle: nil), forCellWithReuseIdentifier: "AztroCell")
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
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return aztroArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AztroCell", for: indexPath) as! AztroCell
        
        cell.aztroLabel.text = aztroArray[indexPath.row]
        cell.aztroImage.image = UIImage(named: "\(aztroArray[indexPath.row])")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let aztroName = aztroArray[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "InfoViewController") as! InfoViewController
        
        dataFetcher.fetchAztro(sign: aztroName) { (aztro) in
            switch aztro {
            case .none:
                print(Error.self)
            case .some(let data):
                let widgetUserDefaults = UserDefaults(suiteName: "group.aztro.WidgetShare")
                widgetUserDefaults?.setValue(data.aztroDescription, forKey: "descriptionKey")
                vc.nameLabel.text = aztroName
                vc.dateLabel.text = data.dateRange
                vc.textLabel.text = data.aztroDescription
            }
        }
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: 150)
    }
}

