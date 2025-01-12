//
//  AppDelegate.swift
//  TableView Programmatically
//
//  Created by Steew on 07.05.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
  var window: UIWindow?
  func application(
    
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:[UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // (1)
    window = UIWindow(frame: UIScreen.main.bounds)
    // (2)
    let viewController = ViewController()
    window?.rootViewController = viewController
    // (3)
    window?.makeKeyAndVisible()
    return true
  }
    
}

