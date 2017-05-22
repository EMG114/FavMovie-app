//
//  UpcomingMoviesViewController.swift
//  MovieApp
//
//  Created by Erica on 10/10/16.
//  Copyright © 2016 Erica Gutierrez. All rights reserved.
//

import UIKit

class UpcomingMoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let store = MovieDataStore.sharedStore
    
    
    @IBOutlet weak var upcomingMovieCollectionView: UICollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
     
        
        
       navigationBarUI()
        
        self.upcomingMovieCollectionView.delegate = self
        self.upcomingMovieCollectionView.dataSource = self
        
        store.api.getMoviesPlayingInTheaters { (array) in
            OperationQueue.main.addOperation({
                
                self.upcomingMovieCollectionView.reloadData()
            })
            
        }
        
        
    }
    
    func navigationBarUI()
    {
        let navigationBar = navigationController!.navigationBar
        navigationBar.barTintColor = UIColor.orange
        navigationBar.alpha = 0.5
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      //  print(store.api.upcomingMovie.count)
        return store.api.upcomingMovie.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingCell", for: indexPath) as! UpcomingMovieCollectionViewCell
        
        if let poster = store.api.upcomingMovie[indexPath.item].poster
        {
            cell.upcomingMovieImagePoster.isHidden = true
            DispatchQueue.main.async(execute: {
                let stringPosterURL = URL(string: "https://image.tmdb.org/t/p/w500"+poster)
                
                if let url = stringPosterURL
                {
                    let dtinternet = try? Data(contentsOf: url)
                    
                    if let unwrappedImage = dtinternet
                    {
                        cell.upcomingMovieImagePoster.isHidden = false
                        cell.upcomingMovieImagePoster.image = UIImage.init(data: unwrappedImage)
                    }
                }
                
            })
            
        }
        cell.upcomingMovieImagePoster.image = UIImage.init(named: "movie-placeholder.png")
        return cell
    }
    
//   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        <#code#>
//    }
    
//    internal func collectionView(_ colectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//          let screenWidth = UIScreen.main.bounds.width
//          let screenHeight = UIScreen.main.bounds.height
//        return CGSize(width: screenWidth, height: screenHeight)
//        
//    }
    
}
