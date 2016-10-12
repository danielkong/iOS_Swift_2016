//
//  TableViewController.swift
//  MemeMe
//
//  Created by Daniel Kong on 10/10/16.
//  Copyright © 2016 Daniel Kong. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var memes = [Meme]()
    let appDele: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewWillAppear(animated: Bool) {
        memes = appDele.sharedData
        tableView.reloadData()
        tabBarController?.tabBar.hidden = false
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellForMeme") as! MemeTableViewCell
        if let meme: Meme = memes[indexPath.row] {
            cell.topLabel.text = meme.topText
            cell.bottomLabel.text = meme.bottomText
            cell.memeImageView.image = meme.memedImage
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailViewController = storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        detailViewController.meme = memes[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            memes.removeAtIndex(indexPath.row)
            appDele.sharedData = memes
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
}
