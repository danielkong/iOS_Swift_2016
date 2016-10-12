//
//  CollectionViewController.swift
//  MemeMe
//
//  Created by Daniel Kong on 10/11/16.
//  Copyright © 2016 Daniel Kong. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes = [Meme]()
    private let spacing: CGFloat = 3.0
    private let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        memes = appDelegate.sharedData
        collectionView.reloadData()
        tabBarController?.tabBar.hidden = false
    }

    override func viewDidLayoutSubviews() {
        adjustLayoutOnOrientation(UIDevice.currentDevice().orientation)
    }
    
    // MARK: private functions
    
    private func adjustLayoutOnOrientation(orientation: UIDeviceOrientation) {
        flowLayout.minimumLineSpacing = spacing
        flowLayout.minimumInteritemSpacing = spacing
        let size = orientation.isPortrait ? (view.frame.size.width - spacing*2)/3 :  (view.frame.size.width - spacing*4)/5
        flowLayout.itemSize = CGSizeMake(size, size)
    }

    // MARK: Collection View Delegate & Data Source
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellForMeme", forIndexPath: indexPath) as! CollectionViewCell
        if let meme: Meme = memes[indexPath.row] where indexPath.row < memes.count {
            cell.memeImageView.image = meme.memedImage
        }
        return cell
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailViewController = storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        if let meme: Meme = memes[indexPath.row] where indexPath.row < memes.count {
            detailViewController.meme = meme
        }
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

