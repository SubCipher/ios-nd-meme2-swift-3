//
//  MemeDetailViewController.swift
//  MeMe2
//
//  Created by kpicart on 2/2/17.
//  Copyright © 2017 StepwiseDesigns. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    /*getting the whole meme here...could have less code overall by using one image for segue and collection/table, but this gives more options to access entire meme dataset */
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