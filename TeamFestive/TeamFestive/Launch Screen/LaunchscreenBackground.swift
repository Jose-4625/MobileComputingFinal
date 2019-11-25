//
//  BackgroundView.swift
//  TeamFestive
//
//  Created by Denis Bowen on 11/13/19.
//  Copyright © 2019 Jose Torres. All rights reserved.
//

import UIKit

class LaunchscreenBackground: UIView {
    
    override func draw(_ rect: CGRect) {
      // 1
      guard let context = UIGraphicsGetCurrentContext() else {
        return
      }
      let backgroundRect = bounds
      context.drawLinearGradient(
        in: backgroundRect,
        startingWith: UIColor.oceanBlue.cgColor,
        finishingWith: UIColor.fadedPink.cgColor
      )
        
    }

}

