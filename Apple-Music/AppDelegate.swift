//
//  AppDelegate.swift
//  Apple-Music
//
//  Created by Cong Le on 4/18/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navController: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let HomeVC = HomeViewController()
        navController = UINavigationController(rootViewController: HomeVC)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
      //  window?.backgroundColor = .white
        
        return true
    }
    
    
}

