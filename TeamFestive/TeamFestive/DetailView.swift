//
//  DetailView.swift
//  TeamFestive
//
//  Created by Denis Bowen on 11/22/19.
//  Copyright © 2019 Jose Torres. All rights reserved.
//

import UIKit

class DetailView: UIView {
  override func draw(_ rect: CGRect) {
    guard let context = UIGraphicsGetCurrentContext() else {
      return
    }

    let backgroundRect = bounds
    context.drawLinearGradient(
      in: backgroundRect,
      startingWith: UIColor.fadedPink.cgColor,
      finishingWith: UIColor.oceanBlue.cgColor
    )
  }
}
