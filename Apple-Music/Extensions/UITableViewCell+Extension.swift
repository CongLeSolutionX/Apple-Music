//
//  UITableViewCell+Extension.swift
//  Apple-Music
//
//  Created by Cong Le on 6/15/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import UIKit

extension UITableViewCell {
    func slideOutFromLeft() {
        self.frame.origin.x = -self.frame.width
        UIView.animate(
            withDuration: 0.7,
            delay: 0.2,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0,
            options: .allowUserInteraction,
            animations: {  self.frame.origin.x = 0 },
            completion: nil )
    }
}
