//
//  MemeCustomRect.swift
//  MeMe2
//
//  Created by kpicart on 2/18/17.
//  Copyright © 2017 StepwiseDesigns. All rights reserved.
//

import UIKit

//create main textFields
var isDeviceVertical = true

class MemeCustomRect: UIViewController  {
    
    //var for holding frame sizes
    internal var activeFrameSize = CGSize()
    private var positionID = String()
    //MARK: - custom textField settings
    
    //set and return CGRect divisors/multiples based on string ID
    private func framePositionCal(positionID: String) ->(positionValue:CGPoint,sizeValue:CGSize) {
        var cgPointDivisor = CGPoint()
        var cgSizeDivisor = CGSize()

        let cgPointDict = ["topTextField" :    [CGPoint(x: -375.0, y: 7.0), CGPoint(x: -667.0, y: 7.0)],
                           "scrollView"   :    [CGPoint(x: -375.0, y: 7.3), CGPoint(x: -667.0, y: 7.2)],
                           "sourceImageView" : [CGPoint(x: 5.0, y: 9.0), CGPoint(x: 3.9, y: 22.0)],
                           "bottomTextField" : [CGPoint(x: -375.0, y: 1.32),CGPoint(x: -667.0, y: 1.3)]]
        
        let cgSizeDict = ["topTextField" :    [CGSize(width: 1.0, height: 15.0), CGSize(width: 1.0, height: 8.9)],
                          "scrollView" :      [CGSize(width: 1.0, height: 1.45), CGSize(width: 1.0, height: 1.4)],
                          "sourceImageView" : [CGSize(width: 1.5, height: 2.0),  CGSize(width: 2.0, height: 1.4)],
                          "bottomTextField" : [CGSize(width: 1.0, height: 15.0), CGSize(width: 1.0, height: 8.9)]]
        
        //set vars for multipliers/divisors used in calculating position during device rotation
        for allPoints in cgPointDict {
            if allPoints.key == positionID {
                //capture values based on the string "positionID" aKa dictKey
                let allSizes = cgSizeDict[positionID]
                if isDeviceVertical == true {
                    cgPointDivisor = allPoints.value[0]
                    cgSizeDivisor = (allSizes?[0])!
                    
                } else {
                    cgPointDivisor = allPoints.value[1]
                    cgSizeDivisor = (allSizes?[1])!
                }
            }
        }
        return  (cgPointDivisor,cgSizeDivisor)
    }
    
    //get current display frame with string ID from global var, set by calling func
    internal func getCGRectPosition(_ ID:String) ->(CGRect){

        positionID = ID
        let memeCGRect = CGRect(x: (activeFrameSize.width / framePositionCal(positionID: positionID).positionValue.x),
                                y: (activeFrameSize.height / framePositionCal(positionID: positionID).positionValue.y),
                                width: activeFrameSize.width / framePositionCal(positionID: positionID).sizeValue.width,
                                height: activeFrameSize.height / framePositionCal(positionID: positionID).sizeValue.height)
        return (memeCGRect)
    }
    
    //MARK -set text and text field attributes
    
    private let memeTextAttrib:[ String : Any] =
        [NSStrokeColorAttributeName: (UIColor .black),
         NSForegroundColorAttributeName: (UIColor .white),
         NSStrokeWidthAttributeName:(size: -1.0),
         NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 36)! ]
    
    internal func textFieldSettings(placeHolderText: String) ->UITextField {
        
        let textField = UITextField()
        
        textField.attributedPlaceholder = NSAttributedString(string: placeHolderText.uppercased(), attributes:[NSFontAttributeName: UIColor.white])
        textField.contentVerticalAlignment = UIControlContentVerticalAlignment.bottom
        textField.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        
        textField.backgroundColor = UIColor.clear
        textField.defaultTextAttributes = memeTextAttrib
        
        textField.adjustsFontSizeToFitWidth = true
        textField.textAlignment = .center
        textField.autocapitalizationType = .allCharacters
        
        return textField
    }
}
