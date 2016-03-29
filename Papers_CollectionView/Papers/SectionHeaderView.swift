//
//  SectionHeaderView.swift
//  Papers
//
//  Created by Daniel Kong on 03/01/2016.
//  Copyright (c) 2016 Hacker. All rights reserved.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
  
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var iconImageView: UIImageView!
  
  var title: String? {
    didSet {
      titleLabel.text = title
    }
  }
  
  var icon: UIImage? {
    didSet {
      iconImageView.image = icon
    }
  }
  
}
