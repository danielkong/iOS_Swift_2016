//
//  Session.swift
//
//
//  Created by Daniel Kong on 02/03/2016.
//  Copyright (c) 2016 Daniel Kong. All rights reserved.
//

import UIKit

class Session {
  
  var title: String
  var speaker: String
  var room: String
  var time: String
  var backgroundImage: UIImage
  
  var timeAndRoom: String {
    get {
      return "\(time) • \(room)"
    }
  }
  
  init(title: String, speaker: String, room: String, time: String, backgroundImage: UIImage) {
    self.title = title
    self.speaker = speaker
    self.room = room
    self.time = time
    self.backgroundImage = backgroundImage
  }
  
  convenience init(dictionary: NSDictionary) {
    let title = dictionary["Title"] as? String
    let speaker = dictionary["Speaker"] as? String
    let room = dictionary["Room"] as? String
    let time = dictionary["Time"] as? String
    let backgroundName = dictionary["Background"] as? String
    let backgroundImage = UIImage(named: backgroundName!)
    self.init(title: title!, speaker: speaker!, room: room!, time: time!, backgroundImage: backgroundImage!.decompressedImage)
  }

}
