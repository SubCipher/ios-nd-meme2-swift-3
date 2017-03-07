//
//  ViewSettings.swift
//  MeMe1
//
//  Created by kpicart on 2/15/17.
//  Copyright © 2017 StepwiseDesigns. All rights reserved.
//

import UIKit

//MARK: - Global var


/*this file sets two global vars used to display images and implements a method to hide views */

var sourceImageView = UIImageView()

//set the prameters for the views frame size, based on its contents
var sourceImage: UIImage? {
    get{
        return sourceImageView.image
    }
    set {
        //new properties for view
        sourceImageView.image = newValue
        sourceImageView.frame.size = sourceImageView.intrinsicContentSize
    }
}


class ViewSettings: UIViewController {
    
    //stand in image if memeImage could not be generated:
    internal let noMemeImage:UIImage? = UIImage(named: "noMemeGenerated")
    
    internal func setSourceImage( ){
        sourceImageView.image = sourceImage
    }
    
    internal func hideNavButtons(_ navShow:Bool, topNavBar: UINavigationItem,bottomNavBar: UIToolbar, button1: UIButton, button2: UIButton){
        button1.isHidden = navShow
        button2.isHidden = navShow
        topNavBar.accessibilityElementsHidden = navShow
        bottomNavBar.isHidden = navShow
    }
}

