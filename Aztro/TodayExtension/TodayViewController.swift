//
//  TodayViewController.swift
//  TodayExtension
//
//  Created by Steew on 06.07.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        let widgetUserDefaults = UserDefaults.init(suiteName: "group.aztro.WidgetShare")
        let text = widgetUserDefaults?.value(forKey: "descriptionKey")
        self.textLabel.text = text as? String
        
        completionHandler(NCUpdateResult.newData)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .compact {
            self.preferredContentSize = maxSize
        } else if activeDisplayMode == .expanded {
            self.preferredContentSize = CGSize(width: maxSize.width, height: 150)
        }
    }
    
}
