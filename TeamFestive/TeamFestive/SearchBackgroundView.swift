//
//  SearchBackgroundView.swift
//  TeamFestive
//
//  Created by Denis Bowen on 11/14/19.
//  Copyright © 2019 Jose Torres. All rights reserved.
//

import UIKit

@IBDesignable class SearchBackgroundView: UIView
{
     @IBInspectable var gradientColor1: UIColor = UIColor.white {
        didSet{
            self.setGradient()
        }
    }
    
    @IBInspectable var gradientColor2: UIColor = UIColor.white {
        didSet{
            self.setGradient()
        }
    }
    
    @IBInspectable var gradientStartPoint: CGPoint = .zero {
        didSet{
            self.setGradient()
        }
    }
    
    @IBInspectable var gradientEndPoint: CGPoint = CGPoint(x: 0, y: 1) {
        didSet{
            self.setGradient()
        }
    }
    
    private func setGradient()
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [self.gradientColor1.cgColor, self.gradientColor2.cgColor]
        gradientLayer.startPoint = self.gradientStartPoint
        gradientLayer.endPoint = self.gradientEndPoint
        gradientLayer.frame = self.bounds
        if let topLayer = self.layer.sublayers?.first, topLayer is CAGradientLayer
        {
            topLayer.removeFromSuperlayer()
        }
        self.layer.addSublayer(gradientLayer)
    }
}
