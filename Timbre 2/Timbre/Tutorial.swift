//
//  Tutorial.swift
//
//
//  Created by Daniel Kong on 02/03/2016.
//  Copyright (c) 2016 Daniel Kong. All rights reserved.
//

import UIKit

class Tutorial: Session {
  
  class func allTutorials() -> [Tutorial] {
    var tutorials = [Tutorial]()
    if let URL = NSBundle.mainBundle().URLForResource("Tutorials", withExtension: "plist") {
      if let tutorialsFromPlist = NSArray(contentsOfURL: URL) {
        for dictionary in tutorialsFromPlist {
          let tutorial = Tutorial(dictionary: dictionary as! NSDictionary)
          tutorials.append(tutorial)
        }
      }
    }
    return tutorials
  }
  
}