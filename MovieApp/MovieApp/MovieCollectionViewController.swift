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
        movieCollectionView.backgroundColor = UIColor.whiteColor()
        
        createSearchBar()
        navigationBarUI()
//
//  self.store.searchForMovie("Black") { (true) in
//  
//   
//    
//    NSOperationQueue.mainQueue().addOperationWithBlock({
//        
//        
//       return self.movieCollectionView.reloadData()
//    })
//    
//        }

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
        
       // navigationBar.backgroundColor = UIColor.blueColor()
        navigationBar.barTintColor = UIColor.orangeColor()
        navigationBar.alpha = 0.5
//        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont(name: "AppleSDGothicNeo-Light", size: 25)!]
//        
//        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "AppleSDGothicNeo-Light", size: 19)!], forState: UIControlState.Normal)
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
         return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return self.store.movieList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("movieCell", forIndexPath: indexPath) as! MovieCollectionCell
        
      cell.backgroundColor = UIColor.blueColor()
      cell.movieTitle.text = "\(indexPath.item)"
        
      if self.store.movieList[indexPath.row].moviePosterUrl == "N/A"
      {
          cell.moviePosterImage.image = UIImage.init(named: "movie-placeholder.jpg")
       }
       
        let posterUrl = NSURL(string: self.store.movieList[indexPath.row].moviePosterUrl)
       
        if let url = posterUrl
       {
           let data = NSData(contentsOfURL: url)
        
          if let unwrappedImage = data
           {
            
                dispatch_async(dispatch_get_main_queue(),{
                  cell.moviePosterImage.image = UIImage.init(data: unwrappedImage)
             })
            
            }
            cell.movieTitle.text = self.store.movieList[indexPath.row].movieTitle
           cell.movieYear.text = self.store.movieList[indexPath.row].movieYear
      }
     
      cell.setNeedsDisplay()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        self.movieID = self.store.movieList[indexPath.row].movieID
        
    }
        

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
       // store.movieList.removeAll()
        if !searchBar.text!.isEmpty {
            // replacing characters space with %
            let percentString = searchBar.text!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
             store.searchForMovie((percentString!), completionHandler: { (true) in
                
                NSOperationQueue.mainQueue().addOperationWithBlock({
                     //self.store.movieList.removeAll()
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
            let destinationVC = segue.destinationViewController as! MovieDetailViewController
            
            let indexPath = movieCollectionView.indexPathForCell(sender as! UICollectionViewCell)
            
            if let unwrappedIndex = indexPath
            {
                let movieID = self.store.movieList[unwrappedIndex.row]
                destinationVC.movie = movieID
            }
            
        }
        
        
    }
   
    
    

}




    

