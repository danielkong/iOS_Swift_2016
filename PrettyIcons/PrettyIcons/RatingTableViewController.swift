//
//  RatingTableViewController.swift
//  PrettyIcons
//
//
//  Created by Daniel Kong on 04/03/2016.
//  Copyright (c) 2016 Daniel Kong. All rights reserved.
//

import UIKit

class RatingTableViewController: UITableViewController {

  var icon: Icon?
  
  func refresh() {
    for index in 0 ... RatingType.TotalRatings.rawValue {
      let indexPath = NSIndexPath(forRow: index, inSection: 0)
      
      if let cell = tableView.cellForRowAtIndexPath(indexPath) {
        cell.accessoryType = icon?.rating.rawValue == index ? .Checkmark : .None
      }

    }
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    refresh()
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    guard let rating = RatingType(rawValue: indexPath.row) else {
      return
    }
    icon?.rating = rating
    refresh()
  }
  
  
}
