//
//  PhotoCell.swift
//
//
//  Created by Daniel Kong on 18/03/2016.
//  Copyright (c) 2016 Razeware LLC. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
  
  @IBOutlet private weak var imageView: UIImageView!
  
  var photo: UIImage? {
    didSet {
      if let photo = photo {
        imageView.image = photo
      }
    }
  }
  
}
