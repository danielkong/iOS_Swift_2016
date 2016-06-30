//
//  RoundedCornersView.swift
//
//
//  Created by Daniel Kong on 03/03/2016.
//  Copyright (c) 2015 Daniel Kong. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedCornersView: UIView {
  
  @IBInspectable var cornerRadius: CGFloat = 0 {
    didSet {
      layer.cornerRadius = cornerRadius
      layer.masksToBounds = cornerRadius > 0
    }
  }
  
}
