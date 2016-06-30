//
//  Inspiration.swift
//
//
//  Created by Daniel Kong on 02/14/2016.
//  Copyright (c) 2016 Daniel Kong. All rights reserved.
//

import UIKit

class Inspiration: Session {
  
  class func allInspirations() -> [Inspiration] {
    var inspirations = [Inspiration]()
    if let URL = NSBundle.mainBundle().URLForResource("Inspirations", withExtension: "plist") {
      if let tutorialsFromPlist = NSArray(contentsOfURL: URL) {
        for dictionary in tutorialsFromPlist {
          let inspiration = Inspiration(dictionary: dictionary as! NSDictionary)
          inspirations.append(inspiration)
        }
      }
    }
    return inspirations
  }
  
}
