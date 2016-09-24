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
   var deleteAllButton: UIBarButtonItem!
  
  
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
      
      
       navigationBarUI()
    
       self.title = "Favorites"
       tableView.backgroundColor = UIColor.darkGrayColor()
    
       store.fetchData()
       self.tableView.reloadData()
    
    
    }
    
    
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(true)
        
    store.fetchData()
       self.tableView.reloadData()
       self.cancel()
        
    }
    
    func navigationBarUI()
    {
        let navigationBar = navigationController!.navigationBar
        navigationBar.barTintColor = UIColor.orangeColor()
        navigationBar.alpha = 0.5
        
     //   self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: #selector(NSProgress.cancel))
     //   self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: UIBarButtonItemStyle.Plain, target: self, action: #selector (self.cancel))
            
            //(NSProgress.cancel))
        
     
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    @IBAction func deleteAllButton(sender: AnyObject) {
        
     //   self.cancel()
     //  store.managedObjectContext.reset()
        
      
            //store.favoriteList.first?.movies
       // store.saveContext()
     
    }
    
    func cancel() {
        
       
//                let fetchRequest = NSFetchRequest(entityName: "Favorite")
//        
//                   // Create Batch Delete Request
//                   let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//        
//                   do {
//                            try store.managedObjectContext.executeRequest(batchDeleteRequest)
//                
//                       } catch {
//                                print("Error")
//                            }
//        }
   

    }
    
 

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       return store.favoriteList.count
     
    }
    
    
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCellWithIdentifier("favoriteMovieCell", forIndexPath: indexPath) as! FavoriteTableViewCell
     
     // Configure the cell...
        
        
        let favoriteMovie = store.favoriteList[indexPath.row].movies
        
        cell.favMovieTitleLabel.text = favoriteMovie?.first?.movieTitle
        cell.favMovieYearLabel.text = favoriteMovie?.first?.movieYear
        cell.favMovieDirectorLabel.text = favoriteMovie?.first?.movieDirector
        cell.favActorsLabel.text = favoriteMovie!.first?.movieDirector
    
        cell.favWriterLabel.text = favoriteMovie?.first?.movieWriter
        
        let imagePoster = favoriteMovie?.first?.moviePosterUrl
        
        if let unwrappedMoviePosterString = imagePoster
        {
            if unwrappedMoviePosterString == "N/A"
            {
                cell.favMoviePosterImage.image = UIImage.init(named:"movie-placeholder.jpg")
            }
            let imagePosterUrl = NSURL(string: unwrappedMoviePosterString)
            if let url = imagePosterUrl
            {
                let dataImage = NSData(contentsOfURL: url)
                
                if let unwrappedPosterImage = dataImage
                {
                    cell.favMoviePosterImage.image = UIImage.init(data: unwrappedPosterImage)
                }
            }
            
        }
        

     cell.backgroundColor = UIColor.darkGrayColor()
     return cell
     }

//override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
//        return UITableViewCellEditingStyle.None
//    }
    
//    override func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return false
//    }
    
    
    
    
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
        

     }
     }
    
    

    
    
     // Override to support rearranging the table view.
//     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
//        
//        let managedcontext = store.managedObjectContext
//     
//      
//        managedcontext.deleteObject(store.favoriteList[fromIndexPath.row])
//       
//      let cellToMove =   store.favoriteList.removeAtIndex(fromIndexPath.row)
//         store.favoriteList.insert(cellToMove, atIndex: toIndexPath.row)
//       
//        store.saveContext()
//        tableView.reloadData()
//     
//     }
// 
    
    
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
 
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
        if segue.identifier == "favoriteToDetailsSegue"
        {
            let destinationVC = segue.destinationViewController as? MovieDetailViewController
            
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
            
            if let index = indexPath
            {
                let movieID = self.store.favoriteList[index.row].movies
               let movieTitle = movieID?.first
                
               let destinationVC = destinationVC
                destinationVC!.movie = movieTitle
                
            }
            
        }
        
    }


}
