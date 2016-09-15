//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Erica on 9/8/16.
//  Copyright © 2016 Erica Gutierrez. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movie: Movie?
    
    let store = MovieDataStore.sharedStore
    
    
    
    
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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "⭐️", style: .Done, target: self, action: #selector(MovieDetailViewController.saveMovieAsFavorite))
        
        view.backgroundColor = UIColor.darkGrayColor()
        movieShortPlotTextView.backgroundColor = UIColor.darkGrayColor()
      //   movieShortPlotTextView.textColor = UIColor.blackColor()
        

        
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
        
        
        
    }
    
    func saveMovieAsFavorite()
    {
        print("save to my favorite list")
    }
    
    
    @IBAction func fullPlotDescriptionButton(sender: AnyObject)
    {
        //segue: This button will go to Long Plot VC
        
  
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
                destinationLongPlotVC!.movie? = unwrappedMovie
                print(destinationLongPlotVC!.movie)
            }
            
        }
        
    }
    
}


