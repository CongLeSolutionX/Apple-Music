//
//  UILabel.swift
//  Apple-Music
//
//  Created by Cong Le on 4/23/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import UIKit


extension CGFloat {
    static let maxFontSize: CGFloat = 30.0
}

extension UIFont {
    class var buttonFont: UIFont {
        let pointSize = min(UIFont.TextStyle.callout.preferredSize, .maxFontSize)
        return UIFont.systemFont(ofSize: pointSize)
    }
}

extension UIFont.TextStyle {
    var preferredSize: CGFloat {
        return UIFont.preferredFont(forTextStyle: self).pointSize
    }
}

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
        let pointSize = min(style?.preferredSize ?? size, .maxFontSize)
        self.font = UIFont.boldSystemFont(ofSize: pointSize)
    }
    
    convenience init(stylizedItalicLabelWithSizeCenterText size: CGFloat,
                     style: UIFont.TextStyle? = nil) {
        self.init()
        stylizeToCenter()
        let pointSize = min(style?.preferredSize ?? size, .maxFontSize)
        self.font = UIFont.italicSystemFont(ofSize: pointSize)
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
        let pointSize = min(style?.preferredSize ?? size, .maxFontSize)
        self.font = UIFont.italicSystemFont(ofSize: pointSize)
    }
}
