//
//  PapersFlowLayout.swift
//  Papers
//
//  Created by Daniel Kong on 3/28/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

class PapersFlowLayout: UICollectionViewFlowLayout {
    var appearingIndexPath: NSIndexPath?
    var disappearingIndexPath: [NSIndexPath]?

    override func initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath)
        // manipulate
        // 1 since appearingIndexPath is optional, need to unwrap it
        if let indexPath = appearingIndexPath {
            if let attributes = attributes {
                if indexPath == itemIndexPath {
                    attributes.alpha = 1.0
                    attributes.center = CGPoint(x: CGRectGetWidth(collectionView!.frame) - 23.5, y: -24.5)
                    attributes.transform = CGAffineTransformMakeScale(0.15, 0.15)
                    attributes.zIndex = 99 // cell appear above all other cells
                }
            }
        }
        return attributes
    }
    
    override func finalLayoutAttributesForDisappearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.finalLayoutAttributesForDisappearingItemAtIndexPath(itemIndexPath)
        if let indexPaths = disappearingIndexPath {
            if let attributes = attributes {
                if indexPaths.contains(itemIndexPath) {
                    attributes.alpha = 1.0
                    attributes.transform = CGAffineTransformMakeScale(0.1, 0.1)
                    attributes.zIndex = -1
                }
            }
        }
        return attributes

    }
}

