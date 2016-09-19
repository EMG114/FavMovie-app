//
//  MovieCollectionViewController.swift
//  MovieApp
//
//  Created by Erica on 9/2/16.
//  Copyright © 2016 Erica Gutierrez. All rights reserved.
//

import UIKit

class MovieCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UISearchBarDelegate{
    
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    var searchBar: UISearchBar!
    
    let store = MovieDataStore.sharedStore
    
    var movieID: String = ""
    var movie : Movie?
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        self.store.searchForMovie("Movie", pages: store.pageNumber) {_ in
            NSOperationQueue.mainQueue().addOperationWithBlock({
                self.movieCollectionView.reloadData()
            })
        }
        
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
       movieCollectionView.backgroundColor = UIColor.darkGrayColor()
        createSearchBar()
        navigationBarUI()
        
        
        
        
    }
    
    
    
    
    func createSearchBar() {
        
        searchBar = UISearchBar(frame: CGRectMake(0, 0, 375, 200))
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Search Movies By Title"
        self.navigationItem.titleView = searchBar
        
        
        
    }
    
    func navigationBarUI()
    {
        let navigationBar = navigationController!.navigationBar
        navigationBar.barTintColor = UIColor.orangeColor()
        navigationBar.alpha = 0.5
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.store.movieList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("movieCell", forIndexPath: indexPath) as! MovieCollectionCell
        
        cell.backgroundColor = UIColor.lightGrayColor()
       
        
        if self.store.movieList[indexPath.row].moviePosterUrl == "N/A"
        {
            cell.moviePosterImage.image = UIImage.init(named: "movie-placeholder.jpg")
           
        }
     
       let posterUrl = NSURL(string: self.store.movieList[indexPath.row].moviePosterUrl!)
      
       
        if let url = posterUrl
        {
            let data = NSData(contentsOfURL:url)
       
            if data != nil
            {
                
                dispatch_async(dispatch_get_main_queue(),{
                    cell.moviePosterImage.image = UIImage.init(data: data!)
                    
                    
                    
              // self.movieCollectionView.reloadData()
                })
                
            }
            cell.movieTitle.text = self.store.movieList[indexPath.row].movieTitle
            cell.movieYear.text = self.store.movieList[indexPath.row].movieYear
              // cell.moviePosterImage.image = UIImage.init(data: data!)
        }
        


        return cell
    }
    
    
  
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        
        self.performSegueWithIdentifier("movieDetailSegue", sender: indexPath)
        
        print("Selected cell index: \(indexPath.row)")
        
        let cell = movieCollectionView.cellForItemAtIndexPath(indexPath)
        cell?.backgroundColor = UIColor.yellowColor()
        
        
    }
    
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = movieCollectionView.cellForItemAtIndexPath(indexPath)
        cell?.backgroundColor = UIColor.lightGrayColor()
      //  movieCollectionView.deselectItemAtIndexPath(indexPath, animated: false)
        
    }
    
    
//func collectionView(collectionView: UICollectionView, selectedItemIndex: NSIndexPath) {
//              let cell = movieCollectionView.cellForItemAtIndexPath(selectedItemIndex)
//                self.performSegueWithIdentifier("movieDetailSegue", sender: cell)
//             
//                        cell?.backgroundColor = UIColor.lightGrayColor()
//            
//            }
    
  
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        if !searchBar.text!.isEmpty {
            // replacing characters space with %
            
            let percentString = searchBar.text!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            
            var queue = NSOperationQueue()
            queue.qualityOfService = .Background
            
            queue.addOperationWithBlock({
                
                
                self.store.searchForMovie((percentString!),pages: self.store.pageNumber,completionHandler: { (true) in
                    
                    NSOperationQueue.mainQueue().addOperationWithBlock({
                        
                        self.movieCollectionView.reloadData()
                
                    })
                })
                
                
                
                
                }
                
                
            )}
        
        
        func searchBarCancelButtonClicked(searchBar: UISearchBar) {
           self.store.movieList.removeAll()
            self.searchBar.resignFirstResponder()
        }
        
        func searchClear(sender: AnyObject) {
            if searchBar.text == ""{
                self.store.movieList.removeAll()
                self.movieCollectionView.reloadData()
            }
        }
        
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "movieDetailSegue" {
            
            if let selectedIndexPath = sender as? NSIndexPath {
                let destinationVC = segue.destinationViewController as! MovieDetailViewController
                let movieID = self.store.movieList[selectedIndexPath.row]
                destinationVC.movie = movieID
            }
            
            
        }
        
               
        
    }
    
    
    
    
}