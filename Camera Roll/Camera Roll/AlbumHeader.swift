//
//  AlbumHeader.swift
//
//
//  Created by Daniel Kong on 18/03/2016.
//  Copyright (c) 2016 Razeware LLC. All rights reserved.
//

import UIKit

class AlbumHeader: UICollectionReusableView {
  
  @IBOutlet private weak var titleLabel: UILabel!
  
  var album: Album? {
    didSet {
      if let album = album {
        titleLabel.text = album.title
      }
    }
  }
  
}
