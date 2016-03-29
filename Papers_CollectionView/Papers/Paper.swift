//
//  Paper.swift
//  Papers
//
//  Created by Daniel Kong on 03/01/2016.
//  Copyright (c) 2016 Hacker. All rights reserved.
//

import UIKit

class Paper {
  
    var caption: String
    var imageName: String
    var section: String
    var index: Int

    init(caption: String, imageName:String, section: String, index: Int) {
        self.caption = caption
        self.imageName = imageName
        self.section = section
        self.index = index
    }

    convenience init(copying paper: Paper) {
        self.init(caption: paper.caption, imageName: paper.imageName, section: paper.section, index: paper.index)
    }
  
}


