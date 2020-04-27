//
//  UIColor+Extension..swift
//  Apple-Music
//
//  Created by Cong Le on 4/26/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
// Source:  https://medium.com/ios-os-x-development/ios-extend-uicolor-with-custom-colors-93366ae148e6


import UIKit

// Converting HEX colors into RGB color
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Wrong red value")
        assert(green >= 0 && green <= 255, "Wrong green value")
        assert(blue >= 0 && blue <= 255, "Wrong blue value")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(HexValue:Int) {
        self.init(red:(HexValue >> 16) & 0xff, green:(HexValue >> 8) & 0xff, blue:HexValue & 0xff)
    }
}

// Various options in HEX color for each flat colors
extension UIColor {
    struct CustomColors {
        struct Blue {
            static let DodgerBlue = UIColor(HexValue: 0x1E90FF)
            static let RoyalBlue = UIColor(HexValue: 0x4169E1)
            static let LightSkyBlue = UIColor(HexValue: 0x87CEFA)
        }
        struct Red {
            static let Crimson = UIColor(HexValue: 0xDC143C)
        }
    }
}
