//
//  Session.swift
//
//
//  Created by Daniel Kong on 06/03/2015.
//  Copyright (c) 2015 Daniel Kong. All rights reserved.
//

import UIKit

class Session {
  
  var title: String
  var speaker: String
  var room: String
  var time: String
  
  var roomAndTime: String {
    get {
      return "\(time) • \(room)"
    }
  }
  
  class func allSessions() -> [Session] {
    var sessions = [Session]()
    if let URL = NSBundle.mainBundle().URLForResource("Sessions", withExtension: "plist") {
      if let sessionsFromPlist = NSArray(contentsOfURL: URL) {
        for dictionary in sessionsFromPlist {
          let session = Session(dictionary: dictionary as! NSDictionary)
          sessions.append(session)
        }
      }
    }
    return sessions
  }
  
  init(title: String, speaker: String, room: String, time: String) {
    self.title = title
    self.speaker = speaker
    self.room = room
    self.time = time
  }
  
  convenience init(dictionary: NSDictionary) {
    let title = dictionary["Title"] as? String
    let speaker = dictionary["Speaker"] as? String
    let room = dictionary["Room"] as? String
    let time = dictionary["Time"] as? String
    self.init(title: title!, speaker: speaker!, room: room!, time: time!)
  }

}
