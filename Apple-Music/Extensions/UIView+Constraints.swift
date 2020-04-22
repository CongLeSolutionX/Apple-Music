//
//  UIView+Constraints.swift
//  Apple-Music
//
//  Created by Cong Le on 4/21/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import UIKit

extension UIView {
    func pin(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints                               = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive             = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive     = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive       = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive   = true
               
    }
}

extension UILabel {
    func stylize(alignment: NSTextAlignment = .left) {
        numberOfLines = 0
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.1
        textAlignment = alignment
    }
    
    convenience init(stylizedBoldLabelWithSize size: CGFloat,
                     style: UIFont.TextStyle? = nil) {
        self.init()
        stylize()
        if let style = style {
            let pointSize = UIFont.preferredFont(forTextStyle: style).pointSize
            self.font = UIFont.boldSystemFont(ofSize: pointSize)
        } else {
            self.font = UIFont.boldSystemFont(ofSize: size)
        }
    }
    
    convenience init(stylizedItalicLabelWithSize size: CGFloat,
                      style: UIFont.TextStyle? = nil) {
        self.init()
        stylize()
        if let style = style {
            let pointSize = UIFont.preferredFont(forTextStyle: style).pointSize
            self.font = UIFont.italicSystemFont(ofSize: pointSize)
        } else {
            self.font = UIFont.italicSystemFont(ofSize: size)
        }
    }
}
