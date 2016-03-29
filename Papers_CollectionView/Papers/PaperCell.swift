//
//  PaperCell.swift
//  Papers
//
//  Created by Daniel Kong on 03/01/2016.
//  Copyright (c) 2016 Hacker. All rights reserved.
//

import UIKit

private let kImage1 = "Unchecked"

class PaperCell: UICollectionViewCell {
  
    @IBOutlet private weak var paperImageView: UIImageView!
    @IBOutlet private weak var gradientView: GradientView!
    @IBOutlet private weak var captionLabel: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!
    
    var editing: Bool = false {
        didSet {
            captionLabel.hidden = editing
            checkImageView.hidden = !editing
        }
    }
    
    // add target-action gesture
    var moving: Bool = false {
        didSet {
            let alpha: CGFloat = moving ? 0.0 : 1.0
            paperImageView.alpha = alpha
            gradientView.alpha = alpha
            captionLabel.alpha = alpha
        }
    }
    
    var snapshot: UIView {
        get {
            let snapshot = snapshotViewAfterScreenUpdates(true)
            let layer = snapshot.layer
            layer.masksToBounds = false
            layer.shadowOffset = CGSize(width: -5.0, height: 0.0)
            layer.shadowRadius = 5.0
            layer.shadowOpacity = 0.4
            return snapshot
        }
    }
    
    // multi-selection
    override var selected: Bool {
        didSet {
            if editing {
                checkImageView.image = UIImage(named: selected ? "Checked" : "Unchecked")
                paperImageView.alpha = selected ? 0.3 : 1.0
            }
        }
    }
    
    // begin
    var paper: Paper? {
        didSet {
            if let paper = paper {
                paperImageView.image = UIImage(named: paper.imageName)
                captionLabel.text = paper.caption
            }
        }
    }
  
}
