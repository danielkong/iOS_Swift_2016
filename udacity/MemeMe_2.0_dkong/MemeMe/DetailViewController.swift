//
//  DetailViewController.swift
//  MemeMe
//
//  Created by Daniel Kong on 10/11/16.
//  Copyright © 2016 Daniel Kong. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var meme: Meme!
    
    override func viewDidLoad() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: #selector(editButtonPressed))
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        imageView?.image = meme.memedImage
        tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.hidden = false
    }
    
    @objc private func editButtonPressed() {
        let vc = storyboard!.instantiateViewControllerWithIdentifier("EditorViewController") as! EditorViewController
        vc.meme = meme
        presentViewController(vc, animated: true, completion: nil)
    }
}
