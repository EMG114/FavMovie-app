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
       tableView.backgroundColor = UIColor.darkGray
    
       store.fetchData()
       self.tableView.reloadData()
    
    
    }
    
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        
    store.fetchData()
       self.tableView.reloadData()
       self.cancel()
        
    }
    
    func navigationBarUI()
    {
        let navigationBar = navigationController!.navigationBar
        navigationBar.barTintColor = UIColor.orange
        navigationBar.alpha = 0.5
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    @IBAction func deleteAllButton(_ sender: AnyObject) {
        
        


       store.favoriteList.removeAll(keepingCapacity: true)
       store.managedObjectContext.reset()
       store.managedObjectContext.refreshAllObjects()
    
       store.saveContext()
    
       self.tableView.reloadData()
     
    }
    
    func cancel() {
  
    }
    
 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       return store.favoriteList.count
     
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteMovieCell", for: indexPath) as! FavoriteTableViewCell
     
     // Configure the cell...
        
        
        let favoriteMovie = store.favoriteList[(indexPath as NSIndexPath).row].movies
        
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
            let imagePosterUrl = URL(string: unwrappedMoviePosterString)
            if let url = imagePosterUrl
            {
                let dataImage = try? Data(contentsOf: url)
                
                if let unwrappedPosterImage = dataImage
                {
                    cell.favMoviePosterImage.image = UIImage.init(data: unwrappedPosterImage)
                }
            }
            
        }
        

     cell.backgroundColor = UIColor.darkGray
     return cell
     }

//override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
//        return UITableViewCellEditingStyle.None
//    }
    
//    override func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return false
//    }
    
    
    
    
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
 
    
    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
        
        
        let managedcontext = store.managedObjectContext
        managedcontext.delete(store.favoriteList[(indexPath as NSIndexPath).row])
        
        store.favoriteList.remove(at: (indexPath as NSIndexPath).row)
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
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if segue.identifier == "favoriteToDetailsSegue"
        {
            let destinationVC = segue.destination as? MovieDetailViewController
            
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            
            if let index = indexPath
            {
                let movieID = self.store.favoriteList[(index as NSIndexPath).row].movies
               let movieTitle = movieID?.first
                
               let destinationVC = destinationVC
                destinationVC!.movie = movieTitle
                
            }
            
        }
        
    }


}
