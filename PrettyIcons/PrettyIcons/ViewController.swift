//
//  DetailViewController.swift
//  PrettyIcons
//
//
//  Created by Daniel Kong on 04/03/2016.
//  Copyright (c) 2016 Daniel Kong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var iconSets:[[Icon?]?]!
  
  /***/
  
  @IBOutlet weak var tableView: UITableView!


  override func viewWillAppear(animated: Bool) {
    tableView.reloadData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
    if identifier == "GoToDetail" && editing {
      return false
    }
    return true
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "GoToEdit" {
      let editViewController = segue.destinationViewController as? EditTableViewController
      if let indexPath = tableView.indexPathForSelectedRow {
        let set = iconSets[indexPath.section]
        let icon = set![indexPath.row]
        editViewController?.icon = icon
      }
    }
  }
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let sectionTitlesCount = UILocalizedIndexedCollation.currentCollation().sectionTitles.count
    var allSections = [[Icon?]?](count: sectionTitlesCount, repeatedValue:nil)
    
    let sets = IconSet.iconSets()
    for iconSet in sets {
      var sectionNumber: Int
      for icon in iconSet.icons {
        let collation = UILocalizedIndexedCollation.currentCollation()
        sectionNumber = collation.sectionForObject(icon, collationStringSelector: "title")
        if allSections[sectionNumber] == nil {
          allSections[sectionNumber] = [Icon?]()
        }
        allSections[sectionNumber]!.append(icon)
      }
    }
    iconSets = allSections
    
    for index in 0 ... iconSets.count - 1 {
      let iconSet = iconSets[index]
      if let set = iconSet {
        set
        iconSets[index] = set.sort(<)
      }
    }
    
    navigationItem.rightBarButtonItem = editButtonItem()
    tableView.allowsSelectionDuringEditing = true
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 70.0
    automaticallyAdjustsScrollViewInsets = false
  }
  
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return UILocalizedIndexedCollation.currentCollation().sectionTitles[section]
  }
  
  
  
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
  
  override func setEditing(editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    if editing {
      tableView.beginUpdates()
      for (index, set) in iconSets.enumerate() {
        let indexPath = NSIndexPath(forRow: set!.count, inSection: index)
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
      }
      tableView.endUpdates()
      tableView.setEditing(true, animated: true)
    } else {
      
      tableView.beginUpdates()
      for (index, set) in iconSets.enumerate() {
        let indexPath = NSIndexPath(forRow: set!.count, inSection: index)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
      }
      
      tableView.endUpdates()
      tableView.setEditing(false, animated: true)
    }
  }
  
  func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
    
    let set = iconSets[indexPath.section]
    if indexPath.row >= set!.count {
      return .Insert
    } else {
      return .Delete
    }
    
  }
  

  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return iconSets.count
  }
  

  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let adjustment = editing ? 1 : 0;
    guard let iconSet = iconSets[section] else {
      return 0
    }
    return iconSet.count
  }
  

  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell: UITableViewCell
    let set = iconSets[indexPath.section]
    
    if indexPath.row >= set!.count && editing {
      cell = tableView.dequeueReusableCellWithIdentifier("NewRowCell", forIndexPath: indexPath)
      cell.textLabel?.text = "Add Icon"
      cell.detailTextLabel?.text = nil
      cell.imageView?.image = nil
    } else {
      cell = tableView.dequeueReusableCellWithIdentifier("IconCell", forIndexPath: indexPath)
      if let iconCell = cell as? IconTableViewCell {
        let icon = set![indexPath.row]
        iconCell.titleLabel.text = icon!.title
        iconCell.subtitleLabel.text = icon!.subtitle
        
        if let iconImage = icon!.image {
          iconCell.iconImageView.image = iconImage
        } else {
          iconCell.iconImageView.image = nil
        }
        
        if icon!.rating == .Awesome {
          iconCell.favoriteImageView.image = UIImage(named: "star_sel.png")
        } else {
          iconCell.favoriteImageView.image = UIImage(named: "star_uns.png")
        }
        
      }

    }
    
    return cell
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

    var set = iconSets[indexPath.section]
    if editingStyle == .Delete {

      set!.removeAtIndex(indexPath.row)
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation:.Automatic)
    } else if editingStyle == .Insert {
      let newIcon = Icon(withTitle: "New Icon", subtitle: "", imageName: nil)
      set!.append(newIcon)
      tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
  }
  
  func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    let set = iconSets[indexPath.section]
    if editing && indexPath.row < set!.count {
      return nil
    }
    return indexPath
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    let set = iconSets[indexPath.section]
    if indexPath.row >= set!.count && editing {
      self.tableView(tableView, commitEditingStyle: .Insert, forRowAtIndexPath: indexPath)
    }
  }
  
  func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    let iconSet = iconSets[indexPath.section]
    if indexPath.row >= iconSet!.count && editing {
      return false
    }
    return true
  }
  
  
  func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
    let set = iconSets[proposedDestinationIndexPath.section]
    if proposedDestinationIndexPath.row >= set!.count {
      return NSIndexPath(forRow: set!.count-1, inSection: proposedDestinationIndexPath.section)
    }
    return proposedDestinationIndexPath
  }
  
  
  
  func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
    return UILocalizedIndexedCollation.currentCollation().sectionIndexTitles
  }
  
  
  func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
    var sectionIndex = UILocalizedIndexedCollation.currentCollation().sectionForSectionIndexTitleAtIndex(index)
    let totalSections = iconSets.count
    
    for counter in index ... totalSections - 1 {
      if iconSets[counter]?.count > 0 {
        sectionIndex = counter
        break
      }
    }
    return sectionIndex
  }
  
}