//
//  MemeDetailViewController.swift
//  MeMe2
//
//  Created by kpicart on 2/2/17.
//  Copyright © 2017 StepwiseDesigns. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    /*getting the whole meme here */
    var meme: MemeBluePrint!
    
    //check where the image is comming from to prevent nil
    var imageFromCollection: Bool?
    
    //capture and display memedImage from segue
    var segueMemedImage: UIImage? {
        didSet {
            imageFromCollection = false
        }
    }
    
    var memeImageView: UIImageView?
    
    @IBOutlet weak var generatedMemeImageOutlet: UIImageView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        generatedMemeImageOutlet?.image = imageFromCollection == true ? meme.memedImage : segueMemedImage
    }
}
