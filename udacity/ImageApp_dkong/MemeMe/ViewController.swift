//
//  ViewController.swift
//  ImagePickerExperiment
//
//  Created by Daniel Kong on 6/25/16.
//  Copyright © 2016 Daniel Kong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    
    @IBOutlet weak var theTopBar: UIToolbar!
    @IBOutlet weak var theNavBar: UIToolbar!
    
    var theMeme: Meme!
    let textFieldDelegate = MemeTextFieldDelegate()
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -4.0,
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        configureTextField(topTextField)
        configureTextField(bottomTextField)

        resetTextFields()
        setButtonsEnabled(false)
    }
    
    func configureTextField(textField: UITextField){
        textField.delegate = textFieldDelegate
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.Center
    }

    func resetTextFields(){
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as!NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder(){
            self.view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
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
    
    
    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        let pickerController = imagePickerWith(sourceType: .PhotoLibrary)
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        let pickerController = imagePickerWith(sourceType: .Camera)
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerWith(sourceType type: UIImagePickerControllerSourceType) -> UIImagePickerController{
        let pickerController = UIImagePickerController()
        pickerController.sourceType = type
        pickerController.delegate = self
        return pickerController
    }

    @IBAction func saveAndSend(sender: AnyObject) {
        generateImage()
        let controller = UIActivityViewController(activityItems: [theMeme.memedImage], applicationActivities: nil)
        controller.completionWithItemsHandler = {
            (activityType: String?, completed: Bool, returnedItems: [AnyObject]?, error: NSError?) ->Void in
                if completed && activityType == UIActivityTypeSaveToCameraRoll {
                    UIImageWriteToSavedPhotosAlbum(self.theMeme.memedImage, nil, nil, nil);
                }
            }
        self.presentViewController(controller, animated: true, completion: nil)
    }

    func generateImage() {
        let memedImage = generateMemedImage()
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, image: imagePickerView.image!, memedImage: memedImage)
        theMeme = meme
    }
    
    @IBAction func cancel(sender: AnyObject){
        imagePickerView.image = nil
        resetTextFields()
        setButtonsEnabled(false)
    }
    
    @IBAction func saveToPhotosAlbum(sender: AnyObject) {
        generateImage()
        UIImageWriteToSavedPhotosAlbum(theMeme.memedImage, nil, nil, nil)
    }
    
    func generateMemedImage() -> UIImage {
        setBarsVisible(true)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        setBarsVisible(false)
        return memedImage
    }
    
    func setButtonsEnabled(state: Bool){
        saveButton.enabled = state
        shareButton.enabled = state
    }
    
    func setBarsVisible(state: Bool){
        theNavBar.hidden = state
        theTopBar.hidden = state
    }
    
}

