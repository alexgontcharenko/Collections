//
//  MainViewController.swift
//  RWRC
//
//  Created by Steew on 25.06.2020.
//  Copyright © 2020 Razeware. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  @IBOutlet weak var backgroundImage: UIImageView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.view.sendSubviewToBack(backgroundImage)
    }

}
