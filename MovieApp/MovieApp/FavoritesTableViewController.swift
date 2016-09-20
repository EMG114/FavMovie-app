//
//  FavoritesTableViewController.swift
//  MovieApp
//
//  Created by Erica on 9/13/16.
//  Copyright © 2016 Erica Gutierrez. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FavoritesTableViewController: UITableViewController {
    
   let store = MovieDataStore.sharedStore

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationBarUI()
    
        self.title = "Favorites"
    
//      self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(NSProgress.cancel))
//     self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: UIBarButtonItemStyle.Done, target: self, action: #selector(NSProgress.cancel))
    
       store.fetchData()
       self.tableView.reloadData()
    
    }
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(true)
        
        store.fetchData()
        self.tableView.reloadData()
        
    }
    
    func navigationBarUI()
    {
        let navigationBar = navigationController!.navigationBar
        navigationBar.barTintColor = UIColor.orangeColor()
        navigationBar.alpha = 0.5
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(NSProgress.cancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: UIBarButtonItemStyle.Done, target: self, action: #selector(NSProgress.cancel))
        
    }
    
    func cancel() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func done() {
        //save things maybe ?
        self.dismissViewControllerAnimated(true, completion: nil)
    }
   


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       //return store.favoriteList.count
        return 100
    }
    
    
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCellWithIdentifier("favoriteMovieCell", forIndexPath: indexPath)
     
     // Configure the cell...
        
        
        
       // let favoriteMovie = store.favoriteList[indexPath.row].movies


        //detailTextLabel.text = movieList
        
        
        
     cell.backgroundColor = UIColor.darkGrayColor()
     return cell
     }

    
    
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
 
    
    
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
        
        
        let managedcontext = store.managedObjectContext
        managedcontext.deleteObject(store.favoriteList[indexPath.row])
        
        store.favoriteList.removeAtIndex(indexPath.row)
        store.saveContext()
        
        self.tableView.reloadData()
        
//
//     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
