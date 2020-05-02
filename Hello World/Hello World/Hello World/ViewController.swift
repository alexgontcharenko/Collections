//
//  ViewController.swift
//  Hello World
//
//  Created by Steew on 02.05.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
            label.center = CGPoint(x: 160, y: 284)
            label.textAlignment = NSTextAlignment.center
            label.text = "Hello World!"
            self.view.addSubview(label)
        }
    }


