//
//  ViewSettings.swift
//  MeMe2
//
//  Created by kpicart on 2/15/17.
//  Copyright © 2017 StepwiseDesigns. All rights reserved.
//

import UIKit

//MARK: - Global var

class ViewSettings: UIViewController {
    
    //stand in image if memeImage could not be generated:
    internal let noMemeImage:UIImage? = UIImage(named: "noMemeGenerated")
        
    internal func hideNavButtons(_ navShow:Bool,toolBar: UIToolbar, button1: UIButton, button2: UIButton){
        button1.isHidden = navShow
        button2.isHidden = navShow
        toolBar.isHidden = navShow
    }
   }

