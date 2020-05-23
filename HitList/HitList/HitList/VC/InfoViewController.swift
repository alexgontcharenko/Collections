//
//  InfoViewController.swift
//  HitList
//
//  Created by Steew on 16.05.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit
import CoreData

//let barController = UITabBarController()
//
//let favorVC = FavouritesVC()
//let mainVC = ViewController()

class InfoViewController: UIViewController {
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactSurnameLabel: UILabel!
    @IBOutlet weak var contactSurname: UILabel!
    @IBOutlet weak var contactPhoneLabel: UILabel!
    @IBOutlet weak var contactPhone: UILabel!
    @IBOutlet weak var contactAdressLabel: UILabel!
    @IBOutlet weak var contactAdress: UILabel!
    @IBOutlet weak var contactEmailLabel: UILabel!
    @IBOutlet weak var contactEmail: UILabel!
    
    var contact: NSManagedObject?
    
    var arrayOfImages: [UIImage] = [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactName.text = contact!.value(forKey: "name") as? String
        contactSurname.text = contact!.value(forKey: "surname") as? String
        contactPhone.text = contact!.value(forKey: "phone") as? String
        contactAdress.text = contact!.value(forKey: "adress") as? String
        contactEmail.text = contact!.value(forKey: "email") as? String
        contactImage.image = arrayOfImages.randomElement()!
        //barController.viewControllers = [favorVC, mainVC]
        
    }
    @IBAction func addToFavourites(_ sender: Any) {
//        if let favouritesViewController = storyboard?.instantiateViewController(identifier: "FavouritesVC") as? FavouritesVC {
//        barController.selectedViewController = favorVC
//        favorVC.favourites.append(contact!)
//        navigationController?.pushViewController(favouritesViewController, animated: true)
        }
    
}
