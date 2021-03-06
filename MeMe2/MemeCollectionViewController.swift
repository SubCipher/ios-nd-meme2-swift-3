//
//  MemeCollectionViewController.swift
//  MeMe2
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
    @IBOutlet weak var noMemeView: UIView!
    
    internal override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        noMemePSA()
       collectionViewOutlet.backgroundColor = UIColor.cyan
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
               
        return cell
    }
    
    internal override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        detailController.imageFromCollection = true
        detailController.meme = appDelegate.memes2[indexPath.row]
        
        navigationController!.pushViewController(detailController, animated: true)
    }
    
    }
