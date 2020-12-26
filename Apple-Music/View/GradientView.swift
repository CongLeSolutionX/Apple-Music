//
//  GradientView.swift
//  Apple-Music
//
//  Created by Cong Le on 4/26/20.
//  Copyright © 2020 CongLeSolutionX. All rights reserved.
//

import UIKit
// Gradient sublayer view adopts with dynamical AutoLayout View
class GradientView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGradientView()
    }
    
    private func setupGradientView() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        guard let theLayer = self.layer as? CAGradientLayer else {
            return;
        }
        
        theLayer.colors = [UIColor.CustomColors.Blue.RoyalBlue.cgColor, UIColor.white.cgColor]
        theLayer.locations = [0.0, 1.0]
        theLayer.frame = self.bounds
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}
