//
//  DetailViewController.swift
//  Papers
//
//  Created by Daniel Kong on 03/01/2016.
//  Copyright (c) 2016 Hacker. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
    @IBOutlet private weak var imageView: UIImageView!

    var paper: Paper?

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        if let paper = paper {
            navigationItem.title = paper.caption
            imageView.image = UIImage(named: paper.imageName)
        }
    }
  
}
