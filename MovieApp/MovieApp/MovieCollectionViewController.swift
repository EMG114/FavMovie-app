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
    
    lazy var searchBar: UISearchBar! = UISearchBar(frame: CGRectMake(0, 0, 375, 200))
    
    let store = MovieDataStore.sharedStore
    
    var movieID: String = ""
    var movie : Movie?
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.backgroundColor = UIColor.darkGrayColor()
        createSearchBar()
        navigationBarUI()

        }
    
    
    func createSearchBar() {
        
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Search Movies By Title"
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
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
     // cell.movieTitle.text = "\(indexPath.item)"
        
      if self.store.movieList[indexPath.row].moviePosterUrl == "N/A"
      {
          cell.moviePosterImage.image = UIImage.init(named: "movie-placeholder.jpg")
       }
       
        let posterUrl = NSURL(string: self.store.movieList[indexPath.row].moviePosterUrl)
       
        if let url = posterUrl
       {
           let data = NSData(contentsOfURL: url)
        
          if data != nil
           {
            
                dispatch_async(dispatch_get_main_queue(),{
                  cell.moviePosterImage.image = UIImage.init(data: data!)
                    

                    
                    self.movieCollectionView.reloadData()
             })
            
            }
            cell.movieTitle.text = self.store.movieList[indexPath.row].movieTitle
           cell.movieYear.text = self.store.movieList[indexPath.row].movieYear
        
      }
     
    // cell.setNeedsDisplay()
        return cell
    }
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        return CGSizeMake((movieCollectionView.frame.width/3), 10)
//        
//        layout.minimumLineSpacing = 0.0;
//        layout.minimumInteritemSpacing = 0.0;
//    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        self.performSegueWithIdentifier("movieDetailSegue", sender: self)
      //  self.movieID = self.store.movieList[indexPath.row].movieID
      //  self.movie?.moviePosterUrl = self.store.movieList[indexPath.row].moviePosterUrl
        
        
    }
    
    // change background color when user touches cell
    
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        
        
        let cell = movieCollectionView.cellForItemAtIndexPath(indexPath)
        cell?.backgroundColor = UIColor.yellowColor()
        
    
    
    
}
    
//    func collectionView(collectionView: UICollectionView, selectedItemIndex: NSIndexPath) {
//      // let cell = movieCollectionView.cellForItemAtIndexPath(selectedItemIndex)
//        self.performSegueWithIdentifier("movieDetailSegue", sender: self)
//    }
    
   //  change background color back when user releases touch
//    func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
//        let cell = movieCollectionView.cellForItemAtIndexPath(indexPath)
//        cell?.backgroundColor = UIColor.orangeColor()
//    }
    

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        store.movieList.removeAll()
        if !searchBar.text!.isEmpty {
            // replacing characters space with %
     
            let percentString = searchBar.text!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
           
             store.searchForMovie((percentString!), completionHandler: { (true) in
                
                NSOperationQueue.mainQueue().addOperationWithBlock({
                   
                
                    return self.movieCollectionView.reloadData()
                    
                })
            
        
        
       // self.searchBar.resignFirstResponder()
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
        if segue.identifier == "movieDetailSegue"
        {
           // let destinationVC = segue.destinationViewController as! MovieDetailViewController
            //let cell = sender as! UICollectionViewCell
            let indexPaths = movieCollectionView.indexPathsForSelectedItems()
            let indexPath = indexPaths![0] as NSIndexPath
            
            let destinationVC = segue.destinationViewController as! MovieDetailViewController
            
          //  destinationVC.movie.movieID = self.store.movieList[indexPath.row]
              //  destinationVC.movie?.movieID = movieID.movieID
                
             //   let moviePoster = self.store.movieList[unwrappedIndex.row]
             //   destinationVC.movie?.moviePosterUrl = moviePoster.moviePosterUrl
                
                
            }
            
        }
        
        
    }
   
    
    






    

