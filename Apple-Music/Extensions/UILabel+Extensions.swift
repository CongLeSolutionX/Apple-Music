//
//  UILabel.swift
//  Apple-Music
//
//  Created by Cong Le on 4/23/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import UIKit

extension UILabel {
    
    func baseTextConfigure() {
        numberOfLines = 0
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.1
    }
    
    func stylizeToCenter(alignment: NSTextAlignment = .center) {
        baseTextConfigure()
        textAlignment = alignment
    }
    func stylizeToLeft(alignment: NSTextAlignment = .left) {
        baseTextConfigure()
        textAlignment = alignment
    }
    
    convenience init(stylizedBoldLabelWithSizeCenterText size: CGFloat,
                     style: UIFont.TextStyle? = nil) {
        self.init()
        stylizeToCenter()
        if let style = style {
            let pointSize = UIFont.preferredFont(forTextStyle: style).pointSize
           self.font = UIFont.boldSystemFont(ofSize: pointSize)
        
            
        } else {
            self.font = UIFont.boldSystemFont(ofSize: size)
        }
    }
    
    convenience init(stylizedItalicLabelWithSizeCenterText size: CGFloat,
                     style: UIFont.TextStyle? = nil) {
        self.init()
        stylizeToCenter()
        if let style = style {
            let pointSize = UIFont.preferredFont(forTextStyle: style).pointSize
            self.font = UIFont.italicSystemFont(ofSize: pointSize)
        } else {
            self.font = UIFont.italicSystemFont(ofSize: size)
        }
    }
    
    convenience init (stylizedBoldLabelWithSizeLeftText size: CGFloat,
                      style: UIFont.TextStyle? = nil) {
        self.init()
        stylizeToLeft()
        if let style = style {
            let pointSize = UIFont.preferredFont(forTextStyle: style).pointSize
            self.font = UIFont.boldSystemFont(ofSize: pointSize)
        } else {
            self.font = UIFont.boldSystemFont(ofSize: size)
        }
    }
    
    convenience init (stylizedItalicLabelWithSizeLeftText size: CGFloat,
                      style: UIFont.TextStyle? = nil) {
        self.init()
        stylizeToLeft()
        if let style = style {
            let pointSize = UIFont.preferredFont(forTextStyle: style).pointSize
            self.font = UIFont.italicSystemFont(ofSize: pointSize)
        } else {
            self.font = UIFont.italicSystemFont(ofSize: size)
        }
    }
}
