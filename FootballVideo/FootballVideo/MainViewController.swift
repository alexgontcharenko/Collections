//
//  ViewController.swift
//  FootballVideo
//
//  Created by Steew on 09.07.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let dataFetcherManager = DataFetcherManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataFetcherManager.fetchVideo { (video) in
            print("\(String(describing: video?.first?.title))")
        }
    }


}

