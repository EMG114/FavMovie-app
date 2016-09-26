//
//  MovieCollectionViewController.swift
//  MovieApp
//
//  Created by Erica on 9/2/16.
//  Copyright © 2016 Erica Gutierrez. All rights reserved.
//

import UIKit
import CoreData


let kREACHABILITYWITHWIFI = "ReachableWithWIFI"
let kNOTREACHABLE = "notReachable"
let kREACHABLEWITHWWAN = "ReachableWithWWAN"

var reachability: Reachability?
var reachabilityStatus = kREACHABILITYWITHWIFI



class MovieCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UISearchBarDelegate{
    
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    
    @IBOutlet weak var searchActivityIndicator: UIActivityIndicatorView!
    
    
    var searchBar: UISearchBar!
    
    let store = MovieDataStore.sharedStore
    
    var movieID: String = ""
    var movie : Movie?
    var pageNumber = 1
    
    var internetReach: Reachability?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
             NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MovieCollectionViewController.reachabilityChanged(_:)), name: kReachabilityChangedNotification, object: nil)
   
        internetReach?.startNotifier()
        
        self.searchActivityIndicator.hidden = false
        self.searchActivityIndicator.startAnimating()
        
        self.store.searchForMovie("Movie", page: self.store.pageNumber) {_ in
            NSOperationQueue.mainQueue().addOperationWithBlock({
                self.movieCollectionView.reloadData()
                self.searchActivityIndicator.hidden = true
                self.searchActivityIndicator.stopAnimating()
            })
        }
        
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.backgroundColor = UIColor.darkGrayColor()
        createSearchBar()
        navigationBarUI()
        
        
        internetReach = Reachability.reachabilityForInternetConnection()
        internetReach?.startNotifier()
        
        self.statusChangedWithReachability(internetReach!)
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
//        if let searchText = searchBar.text {
//        self.store.getNextPage(searchText)
//        self.movieCollectionView.reloadData()
//        
//    }
    }
    
    
    
    func reachabilityChanged(notification: NSNotification)
    {
        print("Reachability status changed")
        reachability = notification.object as? Reachability
        self.statusChangedWithReachability(reachability!)
    }
    
    func statusChangedWithReachability(currentStatus: Reachability)
    {
        let networkStatus: NetworkStatus = currentStatus.currentReachabilityStatus()
        
        print("Status: \(networkStatus.rawValue)")
        
        
        if networkStatus.rawValue == ReachableViaWiFi.rawValue
        {
            print("Reachable with Wifi")
            reachabilityStatus = kREACHABILITYWITHWIFI
             self.movieCollectionView.reloadData()
       
        } else if networkStatus.rawValue == ReachableViaWWAN.rawValue
        {
            print("Reachable with WWAN")
            reachabilityStatus = kREACHABLEWITHWWAN
             self.movieCollectionView.reloadData()
        }
        else if (networkStatus.rawValue == NotReachable.rawValue) {
    reachabilityStatus = kNOTREACHABLE
    print("Network not reachable")
    
    let noNetworkAlertController = UIAlertController(title: "No Network Connection detected", message: "Cannot conduct search", preferredStyle: .Alert)
    
    self.presentViewController(noNetworkAlertController, animated: true, completion: nil)
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
                    noNetworkAlertController.dismissViewControllerAnimated(true, completion: nil)
                  self.movieCollectionView.reloadData()
                })
            }
            
            
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName("reachStatusChanged", object: nil)
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
        
        guard self.store.movieList.count > 0 else { return cell }
        
        cell.backgroundColor = UIColor.lightGrayColor()
       
        
        if self.store.movieList[indexPath.row].moviePosterUrl  == "N/A"
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
                    
                    cell.movieTitle.text = self.store.movieList[indexPath.row].movieTitle
                    cell.movieYear.text = self.store.movieList[indexPath.row].movieYear
                 
          
                })
                
            }
         
            
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
    
    
//    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
//        
//
//        if indexPath.row == store.movieList.count {
//            if let searchText = searchBar.text
//            {
//                dispatch_async(dispatch_get_main_queue(),
//                               {
//                                self.store.getNextPage(searchText)
//                                self.store.searchForMovie((searchText),page: self.pageNumber,completionHandler: { (true) in
//                                    
//                                    NSOperationQueue.mainQueue().addOperationWithBlock({
//                                          self.store.getNextPage(searchText)
//                                        self.movieCollectionView.reloadData()
//                                        
//                                    })
//                                })
//                                   self.store.getNextPage(searchText)
//                                self.movieCollectionView.reloadData()
//                })
//            }
//            
//        }
//    
//
//                
//                                                    }
//        
//    
//    
//    

    
  
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        if !searchBar.text!.isEmpty {
            // replacing characters space with %
            
            let percentString = searchBar.text!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            
            var queue = NSOperationQueue()
            queue.qualityOfService = .Background
            
            queue.addOperationWithBlock({
                
                
                self.store.searchForMovie((percentString!), page: self.pageNumber ,completionHandler: { (true) in
                    
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
    
//    func scrollViewDidScroll(scrollView: UIScrollView)
//    {
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//        if offsetY > contentHeight - scrollView.frame.size.height
//        {
//            
//            if let searchText = searchBar.text
//            {
//                let search = searchText.stringByReplacingOccurrencesOfString(" ", withString: "+").lowercaseString
//                
//                if search == ""
//                {
//
//                   // self.store.getNextPage(searchText)
//                    self.store.searchForMovie(searchText, page: store.pageNumber, completionHandler: { (true) in
//                        dispatch_async(dispatch_get_main_queue(),{
//                             self.store.getNextPage(searchText)
//                            self.movieCollectionView.reloadData()
//                            print(self.store.movieList.count)
//                    })
//                        
//                    })
//                }
//                else if search != ""
//                {
//                    //self.store.getNextPage(searchText)
//                    self.store.searchForMovie(searchText, page: store.pageNumber, completionHandler: {(true) in
//                        dispatch_async(dispatch_get_main_queue(),{
//                            self.store.getNextPage(searchText)
//                            self.movieCollectionView.reloadData()
//                            print(self.store.movieList.count)
//                            
//                        })
//                    })
//                }
//                
//            }
//            print("End of collection view")
//            
//        }
//        
//    }
//
    
override    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
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
