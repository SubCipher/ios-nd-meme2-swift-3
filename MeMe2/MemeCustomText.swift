//
//  MemeCustomText.swift
//  MeMe2
//
//  Created by kpicart on 2/18/17.
//  Copyright © 2017 StepwiseDesigns. All rights reserved.
//

import UIKit

//create main textFields
var memeTextField = (topTextField:UITextField(),bottomTextField: UITextField())

//Bool for reporting device orentation
var isDeviceVertical = true

class MemeCustomText: UIViewController  {
    

//MARK: - custom textField settings
    
    /* creating main textFields in code gave me better layout control than SB when overlaying the views */
    
    //put textFields (top/bottom) into a global var
    internal func setupMemeTextFields(){
        memeTextField = createTextFields()
    }
    
    private func createTextFields() ->(topTextField:UITextField, bottomTextField: UITextField){
        
        var topCGRect = CGRect()
        var bottomCGRect = CGRect()
        
        if isDeviceVertical == true {
            topCGRect = CGRect(x: 85.0, y: 100.0, width: 222.0, height: 42.0)
            bottomCGRect = CGRect(x: 85.0, y: 250, width: 222.0, height: 42.0)
            
        } else {
            topCGRect =  CGRect(x: 205.0, y: 60.0, width: 222.0, height: 42.0)
            bottomCGRect = CGRect(x: 200.0, y: 240.0, width: 222.0, height: 42.0)
        }
        
        let top = textFieldSettings(textCGRect:(topCGRect), placeHolderText: "top")
        let bottom = textFieldSettings(textCGRect:(bottomCGRect), placeHolderText: "bottom")
        
        return (top, bottom)
    }
    
    //MARK -set text and text field attributes
    
   private let memeTextAttrib:[ String : Any] =
        [NSStrokeColorAttributeName: (UIColor .black),
         NSForegroundColorAttributeName: (UIColor .white),
         NSStrokeWidthAttributeName:(size: -1.0),
         NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
    ]
    
    private func textFieldSettings(textCGRect:CGRect, placeHolderText: String) ->UITextField {
        
        let textRect = textCGRect
        let textField = UITextField(frame: textRect)
        
        textField.attributedPlaceholder = NSAttributedString(string: placeHolderText.uppercased(), attributes:[NSFontAttributeName: UIColor.white])
        textField.contentVerticalAlignment = UIControlContentVerticalAlignment.bottom
        
        textField.backgroundColor = UIColor.clear
        textField.defaultTextAttributes = memeTextAttrib
        
        textField.adjustsFontSizeToFitWidth = true
        textField.textAlignment = .center
        textField.autocapitalizationType = .allCharacters
        
        return textField
    }
}
