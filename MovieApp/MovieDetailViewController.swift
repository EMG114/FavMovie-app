//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Erica on 9/8/16.
//  Copyright © 2016 Erica Gutierrez. All rights reserved.
//

import UIKit
import CoreData

class MovieDetailViewController: UIViewController {
    
    var movie: Movie?
    
    let store = MovieDataStore.sharedStore
    
    
    @IBOutlet weak var detailsActivityIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var imageViewPosterLabel: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var movieYearLabel: UILabel!
    
    @IBOutlet weak var movieShortPlotTextView: UITextView!
    
    @IBOutlet weak var movieDirectorLabel: UILabel!
    
    @IBOutlet weak var movieWriterLabel: UILabel!
    
    
    @IBOutlet weak var movieActorsLabel: UILabel!
    
    @IBOutlet weak var imdbScoreLabel: UILabel!
    
    @IBOutlet weak var metascoreLabel: UILabel!
    
    @IBOutlet weak var movieRatedLabel: UILabel!
    
    @IBOutlet weak var movieLanguageLabel: UILabel!
    
    
    @IBOutlet weak var movieCountryLabel: UILabel!
    
    
    @IBOutlet weak var movieRuntimeLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var trailerButton: UIButton!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
 navigationItem.title = movie?.movieTitle
        
        reachabilityStatusChanged()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MovieDetailViewController.reachabilityStatusChanged), name: "reachStatusChanged", object: nil)
        
        self.detailsActivityIndicator.hidden = false
        self.detailsActivityIndicator.startAnimating()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "⭐️", style: .Done, target: self, action: #selector(MovieDetailViewController.saveMovieAsFavorite))
        
       view.backgroundColor = UIColor.darkGrayColor()
        movieShortPlotTextView.backgroundColor = UIColor.darkGrayColor()
    
    
        guard let unwrappedMovie = movie else{return}
        //(movie?.movieID)!
        self.store.getDetailsForMovieByID(unwrappedMovie){success in
            
            dispatch_async(dispatch_get_main_queue(),{
                
                self.movieTitleLabel.text = self.movie?.movieTitle
                self.movieYearLabel.text = self.movie?.movieYear
                self.movieShortPlotTextView.text = self.movie?.moviePlotShort
                self.movieDirectorLabel.text = self.movie?.movieDirector
                self.movieWriterLabel.text = self.movie?.movieWriter
                self.movieActorsLabel.text = self.movie?.movieActors
                self.imdbScoreLabel.text = self.movie?.movieRating
                self.metascoreLabel.text = self.movie?.movieMetascore
                self.movieRuntimeLabel.text = self.movie?.movieRuntime
                self.movieRatedLabel.text = self.movie?.movieRated
                self.genreLabel.text = self.movie?.movieGenre
                self.movieCountryLabel.text = self.movie?.movieCountry
                self.movieLanguageLabel.text = self.movie?.movieLanguage
                
                
                
                if self.movie?.moviePosterUrl == "N/A"
                {
                    self.imageViewPosterLabel.image = UIImage.init(named: "movie-placeholder.jpg")
                }
                
                
                let imageString = self.movie?.moviePosterUrl
                
                if let unwrappedString = imageString
                {
                    let stringPosterUrl = NSURL(string: unwrappedString)
                    if let url = stringPosterUrl
                    {
                        let data = NSData(contentsOfURL: url)
                        
                        if let unwrappedImage = data
                        {
                            self.imageViewPosterLabel.image = UIImage.init(data: unwrappedImage)
                        }
                    }
                    
                }
                
            })
            
            
            
        }
        
        self.movieShortPlotTextView.text = self.movie?.moviePlotShort
        self.movieDirectorLabel.text = self.movie?.movieDirector
        self.movieWriterLabel.text = self.movie?.movieWriter
        self.movieActorsLabel.text = self.movie?.movieActors
        self.imdbScoreLabel.text = self.movie?.movieRating
        self.metascoreLabel.text = self.movie?.movieMetascore
        self.movieRuntimeLabel.text = self.movie?.movieRuntime
        self.movieRatedLabel.text = self.movie?.movieRated
        self.genreLabel.text = self.movie?.movieGenre
        self.movieCountryLabel.text = self.movie?.movieCountry
        self.movieLanguageLabel.text = self.movie?.movieLanguage
        self.detailsActivityIndicator.hidden = true
        self.detailsActivityIndicator.stopAnimating()
        
        
    }
    
    func reachabilityStatusChanged()
    {
        if reachabilityStatus == kNOTREACHABLE
        {
            let noNetworkAlertController = UIAlertController(title: "No Network Connection detected", message: "Cannot conduct search", preferredStyle: .Alert)
            
            self.presentViewController(noNetworkAlertController, animated: true, completion: nil)
            
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.2 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
                    noNetworkAlertController.dismissViewControllerAnimated(true, completion: nil)
                })
            }
            
        }
        else if reachabilityStatus == kREACHABILITYWITHWIFI
        {
            
        }
        else if reachabilityStatus == kREACHABLEWITHWWAN
        {
            
        }
    }
    
    
    func saveMovieAsFavorite()
    {
    
        
        guard let savedThisMovie = self.movie?.movieTitle  else {return}
        let savedAlert = UIAlertController.init(title: "Favorite!", message: "\(savedThisMovie) was saved in favorites", preferredStyle: .Alert)
        
        let doneAction = UIAlertAction.init(title: "Done", style: .Cancel) { (action) in
        }
        savedAlert.addAction(doneAction)
        self.navigationItem.rightBarButtonItem = nil
        self.presentViewController(savedAlert, animated: true){
        }
        
        let managedContext = store.managedObjectContext
        
        let addThisMovie = NSEntityDescription.insertNewObjectForEntityForName("Favorite", inManagedObjectContext: managedContext) as! Favorite
        
        guard let savedMovie = self.movie else {return}
        
        addThisMovie.movies?.insert(savedMovie)
        
        store.saveContext()

 
    }
    
    @IBAction func watchTrailerPressed(sender: AnyObject) {
        
//        guard let unwrappedMovie = movie else{return}
//        //(movie?.movieID)!
//        self.store.getDetailsForMovieByID(unwrappedMovie){success in
//            
//            dispatch_async(dispatch_get_main_queue(),{
//                
//                self.movieTitleLabel.text = self.movie?.movieTitle
//                self.movieYearLabel.text = self.movie?.movieYear
//                }
        
     //   _ = self.movie?.movieTitle as String!
     //   _ = self.movie?.movieYear as String!
        //performSegueWithIdentifier("detailToTrailer", sender: nil)
  //  )}
        

    
}

    @IBAction func fullPlotDescriptionButton(sender: AnyObject)
    {
        //segue: This button will go to Long Plot VC, it just segue...
        // performSegueWithIdentifier("FromDetailToLongSegue", sender: nil)
  
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "FromDetailToLongSegue"
        {
            
            print(movie)
            let destinationLongPlotVC = segue.destinationViewController as? LongPlotViewController
            
            if let unwrappedMovie = movie
            {
                
                print(unwrappedMovie)
                destinationLongPlotVC?.movieId = unwrappedMovie.movieID
              
            }
            
        }
        
    }
    
}


