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
    window?.makeKeyAndVisible()
    window?.backgroundColor = .systemBackground
    
    let trendingVC = TrendingViewController()
    let searchVC = SearchViewController()
    
    let searchNavigation = UINavigationController(rootViewController: searchVC)
    let trendingNavigation = UINavigationController(rootViewController: trendingVC)
    
    let tabBarController = UITabBarController()
    tabBarController.viewControllers = [trendingNavigation, searchNavigation]
    
    window?.rootViewController = tabBarController
    
    return true
  }
}

