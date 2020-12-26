//
//  AppleMusicViewController.swift
//  Apple-Music
//
//  Created by Cong Le on 12/26/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import UIKit

// MARK: - AppleMusicViewController - The parent class
class AppleMusicViewController: UIViewController {
  override init(nibName nibNameOrNil: String?, bundle nibBundkeOrNil: Bundle?) {
    super.init(nibName: nil, bundle: nil)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func commonInit() { }
  
  func setTabBarImage(imageName: String, title: String) {
    let configuration = UIImage.SymbolConfiguration(scale: .large)
    let image = UIImage(systemName: imageName, withConfiguration: configuration)
    tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
  }
}
