//
//  MemeTextFieldDelegate.swift
//  MemeMe
//
//  Created by Daniel Kong on 6/25/16.
//  Copyright © 2016 Daniel Kong. All rights reserved.
//

import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {
    private let MaxChars: Int = 80

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            let newText = (text as NSString).stringByReplacingCharactersInRange(range, withString: string)
            return newText.characters.count <= MaxChars
        }
        
        return false
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if let text = textField.text {
            if text == "TOP" || text == "BOTTOM"{
                textField.text = ""
            
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}