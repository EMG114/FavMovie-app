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



class MovieCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate{
    
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    
    @IBOutlet weak var searchActivityIndicator: UIActivityIndicatorView!
    
    
    var searchBar: UISearchBar!
    
    let store = MovieDataStore.sharedStore
    let apiClient = OmdbAPIClient()
    
    var movieID: String = ""
    var movie : Movie?
    var pageNumber = 1
    
    var internetReach: Reachability?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(MovieCollectionViewController.reachabilityChanged(_:)), name: NSNotification.Name.reachabilityChanged, object: nil)
        
        internetReach?.startNotifier()
        
        self.searchActivityIndicator.isHidden = false
        self.searchActivityIndicator.startAnimating()
        
        self.store.searchForMovie("Movie", pages: self.apiClient.pageNumber) {_ in
            OperationQueue.main.addOperation({
                self.movieCollectionView.reloadData()
                self.searchActivityIndicator.isHidden = true
                self.searchActivityIndicator.stopAnimating()
            })
        }
        
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.backgroundColor = UIColor.darkGray
        createSearchBar()
        navigationBarUI()
        
        
        internetReach = Reachability.forInternetConnection()
        internetReach?.startNotifier()
        
        self.statusChangedWithReachability(internetReach!)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    
    
    func reachabilityChanged(_ notification: Notification)
    {
        print("Reachability status changed")
        reachability = notification.object as? Reachability
        self.statusChangedWithReachability(reachability!)
    }
    
    func statusChangedWithReachability(_ currentStatus: Reachability)
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
            
            let noNetworkAlertController = UIAlertController(title: "No Network Connection detected", message: "Cannot conduct search", preferredStyle: .alert)
            
            self.present(noNetworkAlertController, animated: true, completion: nil)
            DispatchQueue.main.async { () -> Void in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: { () -> Void in
                    noNetworkAlertController.dismiss(animated: true, completion: nil)
                    self.movieCollectionView.reloadData()
                })
            }
            
            
        }
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "reachStatusChanged"), object: nil)
    }
    
    
    func createSearchBar() {
        
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 375, height: 200))
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Search Movies By Title"
        self.navigationItem.titleView = searchBar
        
        
        
    }
    
    func navigationBarUI()
    {
        let navigationBar = navigationController!.navigationBar
        navigationBar.barTintColor = UIColor.orange
        navigationBar.alpha = 0.5
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.store.movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        print("Display!!!!!")
        print("\(indexPath)")
        print("\((indexPath as NSIndexPath).row)")
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionCell
        
          guard self.store.movieList.count > 0 else { return cell as UICollectionViewCell }
  
        cell.backgroundColor = UIColor.lightGray
        
        if let posterURL = self.store.movieList[(indexPath as NSIndexPath).row].moviePosterUrl {
            if posterURL == "N/A" {
                DispatchQueue.main.async(execute: {
                    cell.moviePosterImage.image = UIImage.init(named: "movie-placeholder.jpg")
                })
            }
        }
        
        let posterUrl = URL(string: self.store.movieList[(indexPath as NSIndexPath).row].moviePosterUrl!) 
        
        if let url = posterUrl
        {
            let data = try? Data(contentsOf: url)
            
            if data != nil
            {
                
                DispatchQueue.main.async(execute: {
                    cell.moviePosterImage.image = UIImage.init(data: data!)
                    cell.movieTitle.text = self.store.movieList[(indexPath as NSIndexPath).row].movieTitle
                    cell.movieYear.text = self.store.movieList[(indexPath as NSIndexPath).row].movieYear
                })
                
            }
            
            
        }
        
  

        
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        self.performSegue(withIdentifier: "movieDetailSegue", sender: indexPath)
        
        print("Selected cell index: \((indexPath as NSIndexPath).row)")
        
       let cell = movieCollectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.yellow
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = movieCollectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.lightGray
       // movieCollectionView.deselectItemAtIndexPath(indexPath, animated: false)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
//        
       let searchResult = searchBar.text
        guard let unwrappedSearch = searchResult else {return}
//        
        if self.store.movieList.count - 1 == (indexPath as NSIndexPath).row {
            
            //    print("\n\nmovieList.count: \(self.store.movieList.count) == indexPath.row: \(indexPath.row)\n\n")
            
            if unwrappedSearch == ""
            {
                self.apiClient.getNextPage()
                self.store.searchForMovie("Movie", pages: apiClient.pageNumber, completionHandler: { (success) in
                    DispatchQueue.main.async(execute: {
                        self.movieCollectionView?.reloadData()
                    })
                })
                
            }
            if unwrappedSearch != ""
            {
                
               self.apiClient.getNextPage()
                
                
                self.store.searchForMovie(unwrappedSearch, pages: apiClient.pageNumber,completionHandler: { (success) in
                    
                    DispatchQueue.main.async(execute: {
                        self.movieCollectionView?.reloadData()
                    })
                })
                
            }
            
        }
        
        
        
        
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if !searchBar.text!.isEmpty {
            // replacing characters space with %
            store.movieList.removeAll()
            let percentString = searchBar.text!.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            
            var queue = OperationQueue()
            queue.qualityOfService = .background
            
            queue.addOperation({
                
                
                self.store.searchForMovie((percentString!), pages: self.apiClient.pageNumber ,completionHandler: { (true) in
                    
                    OperationQueue.main.addOperation({
                        
                        self.movieCollectionView.reloadData()
                        
                    })
                })
                
                
                
                
                }
                
                
            )}
        
    
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         //   self.store.movieList.removeAll()
            self.searchBar.resignFirstResponder()
        }
        
        func searchClear(_ sender: AnyObject) {
            if searchBar.text == ""{
                self.store.movieList.removeAll()
                self.movieCollectionView.reloadData()
            }
        }
        
        
    }
    
    
    override    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "movieDetailSegue" {
            
            if let selectedIndexPath = sender as? IndexPath {
                let destinationVC = segue.destination as! MovieDetailViewController
                let movieID = self.store.movieList[(selectedIndexPath as NSIndexPath).row]
                destinationVC.movie = movieID
            }
            
            
        }
        
        
        
    }
    
    
}
