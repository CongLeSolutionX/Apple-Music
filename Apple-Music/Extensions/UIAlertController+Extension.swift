//
//  UIAlertController.swift
//  Apple-Music
//
//  Created by Cong Le on 4/25/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import UIKit

extension UIAlertController {
    func fixNegativeConstraintError() {
        for subView in self.view.subviews {
            for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
                subView.removeConstraint(constraint)
            }
        }
    }
}
