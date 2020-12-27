//
//  UIView+Constraints.swift
//  Apple-Music
//
//  Created by Cong Le on 4/21/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import UIKit

extension UIView {
    // pre-define constraint to the superview
    func pin(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          topAnchor.constraint(equalTo: superView.topAnchor),
          leadingAnchor.constraint(equalTo: superView.leadingAnchor),
          bottomAnchor.constraint(equalTo: superView.bottomAnchor),
          trailingAnchor.constraint(equalTo: superView.trailingAnchor)
        ])
    }
    
    // Add a crimson shadow to a view
    func addCrimsonShadow(cornerRadius: CGFloat) {
        layer.shadowColor = UIColor.CustomColors.Red.Crimson.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        layer.cornerRadius = cornerRadius
        layer.shadowRadius = 10.0
    }
}

