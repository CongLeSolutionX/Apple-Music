//
//  SearchViewController.swift
//  Apple-Music
//
//  Created by Cong Le on 12/26/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import Foundation
// SearchViewController allows to search, downlaod and play Apple songs 
class SearchViewController: AppleMusicViewController {
  override func viewDidLoad() {
    view.backgroundColor = .systemIndigo
    title = "Search Music"
  }
  
  override func commonInit() {
    setTabBarImage(imageName: "magnifyingglass.circle", title: "Search")
  }
}
