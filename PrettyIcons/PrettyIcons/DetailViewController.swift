//
//  DetailViewController.swift
//  PrettyIcons
//
//
//  Created by Daniel Kong on 04/03/2016.
//  Copyright (c) 2016 Daniel Kong. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  var icon: Icon?
  @IBOutlet weak var imageView: UIImageView!
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    guard let icon = icon else {
      return
    }
    
    if let iconImage = icon.image {
      imageView.image = iconImage
    }
    
  }

}
