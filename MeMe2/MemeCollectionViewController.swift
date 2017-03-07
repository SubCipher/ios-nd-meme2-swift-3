//
//  MemeCollectionViewController.swift
//  MeMe1
//
//  Created by knax on 3/3/17.
//  Copyright © 2017 StepwiseDesigns. All rights reserved.
//

import UIKit


//setup local appDelgate to access data source
let appDelegate = UIApplication.shared .delegate as! AppDelegate


class MemeCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    
    override func viewDidLoad() {
        
        //configure grid spacing for collection view
        let space: CGFloat = 2
        let dimensionW = (view.frame.size.width - (2 * space)) / 3.0
        let dimensionH = (view.frame.size.height - (2 * space)) / 3.5
        
        flowViewLayout.minimumInteritemSpacing = CGFloat(space)
        flowViewLayout.minimumLineSpacing = CGFloat(space)
        flowViewLayout.itemSize = CGSize(width: dimensionW,height: dimensionH)
       }
    
    @IBOutlet weak var noMemeView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //if no images are in the array give some instructions on what to do
        noMemePSA()
        collectionViewOutlet.reloadData()
    }
    
    internal func noMemePSA(){
        if appDelegate.memes2.isEmpty {
            noMemeView.isHidden = false
        } else {
            noMemeView.isHidden = true
        }

    }

    internal override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.memes2.count
    }
    
    internal override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell

        let singleCell = appDelegate.memes2[((indexPath as NSIndexPath!).row)]
        
        cell.memeImageView.image = singleCell.memedImage
        cell.memeNameLabel?.text = singleCell.topText
        
        return cell
    }
    
    internal override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeViewController") as! MemeViewController
        
        detailController.imageFromCollection = true
        detailController.meme = appDelegate.memes2[indexPath.row]
        
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}
