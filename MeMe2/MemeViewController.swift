//
//  MemeViewController.swift
//  MeMe2
//
//  Created by kpicart on 2/2/17.
//  Copyright © 2017 StepwiseDesigns. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController {
    /*getting the whole meme here...could have less code overall by using one image for segue and collection/table, but this gives more options to access entire meme dataset */
    var meme: MemeBluePrint!
    
    //check if image is coming from segue or collection/table view to prevent nil
    var imageFromCollection: Bool?
    
    //get memedImage from segue
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
