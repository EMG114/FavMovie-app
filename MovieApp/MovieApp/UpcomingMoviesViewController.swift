//
//  UpcomingMoviesViewController.swift
//  MovieApp
//
//  Created by Erica on 10/10/16.
//  Copyright © 2016 Erica Gutierrez. All rights reserved.
//

import UIKit

class UpcomingMoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let store = MovieDataStore.sharedStore
    
    @IBOutlet weak var upcomingMovieCollectionView: UICollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        upcomingMovieCollectionView.delegate = self
        upcomingMovieCollectionView.dataSource = self
        
  
        
        
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
           let cell = collectionView.dequeueReusableCellWithReuseIdentifier("upcomingCell", forIndexPath: indexPath) as! UpcomingMovieCollectionViewCell
        
         return cell
    }
    
    
    
}
