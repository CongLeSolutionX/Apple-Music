//
//  UIColor+Extensions.swift
//  Apple-Music
//
//  Created by Cong Le on 4/24/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let customRed = CGFloat(red)/255
        let customGreen = CGFloat(green)/255
        let customBlue = CGFloat(blue)/255
        
       self.init(red: Int(customRed), green: Int(customGreen), blue: Int(customBlue) )
    }
}
