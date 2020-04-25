//
//  UIIMageView.swift
//  Apple-Music
//
//  Created by Cong Le on 4/24/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import UIKit

extension UIImageView {
    func configureCornerRadius(){
        contentMode = .scaleAspectFit
        clipsToBounds = true
        layer.cornerRadius = 10.0 
    }
}

