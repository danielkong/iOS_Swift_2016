//
//  ViewController.swift
//  MemeMe
//
//  Created by Daniel Kong on 6/25/16.
//  Copyright © 2016 Daniel Kong. All rights reserved.
//

import UIKit

class EditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topBar: UIToolbar!
    @IBOutlet weak var bottomBar: UIToolbar!
    
    private let kTOPDEFAULT = "TOP"
    private let kBOTTOMDEFAULT = "BOTTOM"
    private let textFieldDelegate = MemeTextFieldDelegate()

    var meme: Meme!
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentMeme = meme {

            tabBarController?.tabBar.hidden = true
            imagePickerView?.image = currentMeme.image
            hiddenBars(false)
            setButtonsEnabled(true)
            bottomBar.hidden = true

        } else {
            bottomBar.hidden = false
            cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
            setButtonsEnabled(false)
        }
        if let topTextField = topTextField {
            configureTextField(topTextField)
        }
        if let bottomTextField = bottomTextField {
            configureTextField(bottomTextField)
        }
    }
    
    private func configureTextField(textField: UITextField){
        textField.delegate = textFieldDelegate
        textField.defaultTextAttributes = [
                NSStrokeColorAttributeName : UIColor.blackColor(), NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!, NSStrokeWidthAttributeName : -5.0, ]
        textField.textAlignment = NSTextAlignment.Center
        if let currentMeme = meme {
            textField.text = textField == topTextField ? currentMeme.topText : currentMeme.bottomText
        } else {
            textField.text = textField == topTextField ? kTOPDEFAULT : kBOTTOMDEFAULT
        }
        textField.enabled = true
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as!NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }

    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EditorViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EditorViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            setButtonsEnabled(true)
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        if imagePickerView.image == nil {
            setButtonsEnabled(false)
        }
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func pickImageFromLibrary(sender: AnyObject) {
        imagePickerWith(sourceType: .PhotoLibrary)
    }

    @IBAction func pickImageFromCamera(sender: AnyObject) {
        imagePickerWith(sourceType: .Camera)
    }
    
    func imagePickerWith(sourceType type: UIImagePickerControllerSourceType) {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = type
        pickerController.delegate = self
        presentViewController(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        createImage()
        UIImageWriteToSavedPhotosAlbum(meme.memedImage, nil, nil, nil)
        appDelegate.sharedData.append(meme)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func shareButtonPressed(sender: AnyObject) {
        createImage()
        let controller = UIActivityViewController(activityItems: [meme.memedImage], applicationActivities: nil)
        controller.completionWithItemsHandler = {
            (activityType: String?, completed: Bool, returnedItems: [AnyObject]?, error: NSError?) ->Void in
            if completed && activityType == UIActivityTypeSaveToCameraRoll {
                UIImageWriteToSavedPhotosAlbum(self.meme.memedImage, nil, nil, nil)
                self.appDelegate.sharedData.append(self.meme)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        presentViewController(controller, animated: true, completion: nil)
    }
    
    func createImage() {
        
        hiddenBars(true)
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        hiddenBars(false)

        let memeGenerator = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, image: imagePickerView.image!, memedImage: memedImage)
        meme = memeGenerator
    }
    
    @IBAction func cancelPressed(sender: AnyObject) {
        imagePickerView.image = nil
        setButtonsEnabled(false)
        topTextField.text = kTOPDEFAULT
        bottomTextField.text = kBOTTOMDEFAULT
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setButtonsEnabled(state: Bool){
        saveButton.enabled = state
        shareButton.enabled = state
    }
    
    func hiddenBars(hidden: Bool){
        bottomBar?.hidden = hidden
        topBar?.hidden = hidden
    }
    
}

