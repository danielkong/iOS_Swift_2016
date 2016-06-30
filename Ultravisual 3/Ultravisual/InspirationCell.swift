//
//  TutorialCell.swift
//
//
//  Created by Daniel Kong on 02/14/2016.
//  Copyright (c) 2016 Daniel Kong. All rights reserved.
//

import UIKit

class InspirationCell: UICollectionViewCell {
  
  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var imageCoverView: UIView!
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var timeAndRoomLabel: UILabel!
  @IBOutlet private weak var speakerLabel: UILabel!
  
  var inspiration: Inspiration? {
    didSet {
      if let inspiration = inspiration {
        imageView.image = inspiration.backgroundImage
        titleLabel.text = inspiration.title
        timeAndRoomLabel.text = inspiration.roomAndTime
        speakerLabel.text = inspiration.speaker
      }
    }
  }
  
  override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
    super.applyLayoutAttributes(layoutAttributes)
    
    let featuredHeight = UltravisualLayoutConstants.Cell.featuredHeight
    let standardHeight = UltravisualLayoutConstants.Cell.standardHeight
        
    let delta = 1 - ((featuredHeight - CGRectGetHeight(frame)) / (featuredHeight - standardHeight))
    
    let minAlpha: CGFloat = 0.3
    let maxAlpha: CGFloat = 0.75
    
    imageCoverView.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
    
    let scale = max(delta, 0.5)
    titleLabel.transform = CGAffineTransformMakeScale(scale, scale)
    
    timeAndRoomLabel.alpha = delta
    speakerLabel.alpha = delta
  }
  
}
