//
//  CGContextExtensions.swift
//  TeamFestive
//
//  Created by Denis Bowen on 11/17/19.
//  Copyright © 2019 Jose Torres. All rights reserved.
//

import UIKit

extension CGContext {
  func drawLinearGradient(
    in rect: CGRect,
    startingWith startColor: CGColor,
    finishingWith endColor: CGColor
    ) {
    let colorSpace = CGColorSpaceCreateDeviceRGB()

    let locations = [0.0, 1.0] as [CGFloat]

    let colors = [startColor, endColor] as CFArray

    guard let gradient = CGGradient(
      colorsSpace: colorSpace,
      colors: colors,
      locations: locations
      ) else {
        return
    }

    let startPoint = CGPoint(x: rect.midX, y: rect.minY)
    let endPoint = CGPoint(x: rect.midX, y: rect.maxY)

    saveGState()

    addRect(rect)
    clip()
    drawLinearGradient(
      gradient,
      start: startPoint,
      end: endPoint,
      options: CGGradientDrawingOptions()
    )

    restoreGState()
  }
}

