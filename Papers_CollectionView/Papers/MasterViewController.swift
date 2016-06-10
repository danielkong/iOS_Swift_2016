//
//  MasterViewController.swift
//  Papers
//
//  Created by Daniel Kong on 03/01/2016.
//  Copyright (c) 2016 Hacker. All rights reserved.
//

import UIKit

class MasterViewController: UICollectionViewController {
  
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    private var papersDataSource = PapersDataSource()
    private var snapshot: UIView?
    private var sourceIndexPath: NSIndexPath?
    
    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        // toolbar
        navigationController!.toolbarHidden = true

        // delete
        navigationItem.leftBarButtonItem = editButtonItem()

        // init set layout
        let width = CGRectGetWidth(collectionView!.frame) / 3
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
        // gesture
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "handleLongPress:")
        collectionView!.addGestureRecognizer(longPressGestureRecognizer)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MasterToDetail" {
            let detailViewController = segue.destinationViewController as! DetailViewController
            detailViewController.paper = sender as? Paper
        }
    }
  
    @IBAction func deleteButtonTapped(sender: UIBarButtonItem) {
        let indexPaths = collectionView!.indexPathsForSelectedItems()! as [NSIndexPath]
        papersDataSource.deleteItemsAtIndexPaths(indexPaths)
        
//        collectionView!.deleteItemsAtIndexPaths(indexPaths) // without animation
        let layout = collectionViewLayout as! PapersFlowLayout
        layout.disappearingIndexPath = indexPaths
        UIView.animateWithDuration(0.65, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
            self.collectionView!.deleteItemsAtIndexPaths(indexPaths)
        }) { (finished: Bool) -> Void in
            layout.disappearingIndexPath = nil
        }
    }
    
    // MARK: add cell
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        let indexPath = papersDataSource.indexPathForNewRandomPaper() // add item to model in func 'indexPathForNewRandomPaper'
        
        // layout
        let layout = collectionViewLayout as! PapersFlowLayout
        layout.appearingIndexPath = indexPath
        
        // since custom layout, remove this line:
//        collectionView!.insertItemsAtIndexPaths([indexPath]) // without animation
        // animation
        UIView.animateWithDuration(1.0, delay:0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.0, options: .CurveEaseInOut, animations: {() -> Void in
            self.collectionView!.insertItemsAtIndexPaths([indexPath])
//        }, completion: nil)
        }, completion: { (finished: Bool) -> Void in
            layout.appearingIndexPath = nil
        })
    }
    
    private func updateSnapshotView(center: CGPoint, transform: CGAffineTransform, alpha: CGFloat) {
        if let snapshot = snapshot {
            snapshot.center = center
            snapshot.transform = transform
            snapshot.alpha = alpha
        }
    }
    
    func handleLongPress(recognizer: UILongPressGestureRecognizer) {
        if editing {
            return
        }
        
        let location = recognizer.locationInView(collectionView)
        let indexPath = collectionView!.indexPathForItemAtPoint(location)
        
        switch recognizer.state {
        case .Began:
            if let indexPath = indexPath {
                sourceIndexPath = indexPath
                let cell = collectionView!.cellForItemAtIndexPath(indexPath) as! PaperCell
                snapshot = cell.snapshot
                updateSnapshotView(cell.center, transform: CGAffineTransformIdentity, alpha: 0.0)
                collectionView!.addSubview(snapshot!)
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.updateSnapshotView(cell.center, transform: CGAffineTransformMakeScale(1.05, 1.05), alpha: 0.95)
                    cell.moving = true
                })
            }
        case .Changed:
            guard let snapshot = self.snapshot else {
                return
            }
            snapshot.center = location
            if let indexPath = indexPath {
                papersDataSource.movePaperAtIndexPath(sourceIndexPath!, toIndexPath: indexPath)
                collectionView!.moveItemAtIndexPath(sourceIndexPath!, toIndexPath: indexPath)
                sourceIndexPath = indexPath
            }
        default:
            guard let finalSourceIndexPath = sourceIndexPath else {
                return
            }
            let cell = collectionView!.cellForItemAtIndexPath(finalSourceIndexPath) as! PaperCell
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.updateSnapshotView(cell.center, transform: CGAffineTransformIdentity, alpha: 0.0)
                cell.moving = false
                }, completion: { (finished: Bool) -> Void in
                    self.snapshot!.removeFromSuperview()
                    self.snapshot = nil
            })
            sourceIndexPath = nil
        }
    }
    
    // MARK: UICollectionViewDataSource
      
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return papersDataSource.numberOfSections
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return papersDataSource.numberOfPapersInSection(section)
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PaperCell", forIndexPath: indexPath) as! PaperCell
        if let paper = papersDataSource.paperForItemAtIndexPath(indexPath) {
            cell.paper = paper
            cell.editing = editing
        }
        return cell
    }

    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "SectionHeader", forIndexPath: indexPath) as! SectionHeaderView
        if let title = papersDataSource.titleForSectionAtIndexPath(indexPath) {
            sectionHeaderView.title = title
            sectionHeaderView.icon = UIImage(named: title)
        }
        return sectionHeaderView
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if (editing) {
            navigationController!.setToolbarHidden(false, animated: false)
        } else {
            if let paper = papersDataSource.paperForItemAtIndexPath(indexPath) {
                performSegueWithIdentifier("MasterToDetail", sender: paper)
            }
        }
    }
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        if editing {
            if collectionView.indexPathsForSelectedItems()?.count == 0 {
                navigationController!.setToolbarHidden(true, animated: false)
            }
        }
    }
  
    // use edit mode delete cell
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        addButton.enabled = !editing
        collectionView!.allowsMultipleSelection = editing
        let indexPaths = collectionView!.indexPathsForVisibleItems() as [NSIndexPath]
        for indexPath in indexPaths {
            collectionView!.deselectItemAtIndexPath(indexPath, animated: false)
            let cell = collectionView!.cellForItemAtIndexPath(indexPath) as! PaperCell
            cell.editing = editing
        }
        
        if !editing {
            navigationController!.setToolbarHidden(true, animated: false)
        }
    }
}
