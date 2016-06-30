//
//  ScheduleCell.swift
//
//
//  Created by Daniel Kong on 06/03/2015.
//  Copyright (c) 2015 Daniel Kong. All rights reserved.
//

import UIKit

class ScheduleCell: UICollectionViewCell {
  
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var timeAndRoomLabel: UILabel!
  @IBOutlet private weak var separatorViewHeightLayoutConstraint: NSLayoutConstraint!
  
  var session: Session? {
    didSet {
      if let session = session {
        titleLabel.text = session.title
        timeAndRoomLabel.text = session.roomAndTime
      }
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    separatorViewHeightLayoutConstraint.constant = 0.5
  }
  
}
