//
//  MemeTableViewController.swift
//  MeMe1
//
//  Created by knax on 3/6/17.
//  Copyright © 2017 StepwiseDesigns. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
   override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
// MARK: - Table view data source

    internal override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.memes2.count
    }

    internal override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)

        let singleCell = appDelegate.memes2[indexPath.row]
        
        cell.textLabel?.text = singleCell.topText
        cell.imageView?.image = singleCell.memedImage
        
        return cell
    }
    //delte on swipe
    internal override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            appDelegate.memes2.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    internal override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeViewController") as! MemeViewController
        
        detailController.imageFromCollection = true
        detailController.meme = appDelegate.memes2[indexPath.row]
        
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}




