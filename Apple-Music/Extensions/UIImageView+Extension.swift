//
//  UIIMageView.swift
//  Apple-Music
//
//  Created by Cong Le on 4/24/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import UIKit

extension UIImageView {
    // make the UIImage conrners round 
    func configureCornerRadius(cornerRadius: CGFloat){
        contentMode = .scaleAspectFit
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
    }
    
}

