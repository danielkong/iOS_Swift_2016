//
//  TimbreLayout.swift
//
//
//  Created by Daniel Kong on 02/03/2016.
//  Copyright (c) 2016 Daniel Kong. All rights reserved.
//

import UIKit

func degreesToRadians(degrees: Double) -> CGFloat {
  return CGFloat(M_PI * (degrees) / 180.0)
}

class TimbreLayout: UICollectionViewFlowLayout {
 
  override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var layoutAttributes = super.layoutAttributesForElementsInRect(rect)! as [UICollectionViewLayoutAttributes]
    for attributes in layoutAttributes {
      let frame = attributes.frame
      attributes.transform = CGAffineTransformMakeRotation(degreesToRadians(-14))
      attributes.frame = CGRectInset(frame, 12, 0)
    }
    return layoutAttributes
  }
  
}
