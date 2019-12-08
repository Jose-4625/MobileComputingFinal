//
//  ListCellBackground.swift
//  TeamFestive
//
//  Created by Denis Bowen on 11/17/19.
//  Copyright © 2019 Jose Torres. All rights reserved.
//

import UIKit

class ListCellBackground: UIView {
    
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
        
      let strokeRect = backgroundRect.insetBy(dx: 4.5, dy: 4.5)
      context.setStrokeColor(UIColor.matteGrey.cgColor)
      context.setLineWidth(1)
      context.stroke(strokeRect)

      // 2
      //context.setFillColor(UIColor.red.cgColor)
      // 3
      //context.fill(bounds)
    }



}
