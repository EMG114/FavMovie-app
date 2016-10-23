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
    var movieID: String?
    let youtubeURL = "https://www.youtube.com/embed/"

    
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
        checkIfTrailerExist()
        checkingStatusCode()
        reachabilityStatusChanged()
        
        NotificationCenter.default.addObserver(self, selector: #selector(MovieDetailViewController.reachabilityStatusChanged), name: NSNotification.Name(rawValue: "reachStatusChanged"), object: nil)
        
        self.detailsActivityIndicator.isHidden = false
        self.detailsActivityIndicator.startAnimating()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "⭐️", style: .done, target: self, action: #selector(MovieDetailViewController.saveMovieAsFavorite))
        
       view.backgroundColor = UIColor.darkGray
        movieShortPlotTextView.backgroundColor = UIColor.darkGray
    
    
        guard let unwrappedMovie = movie else{return}
        //(movie?.movieID)!
        self.store.getDetailsForMovieByID(unwrappedMovie){success in
            
            DispatchQueue.main.async(execute: {
                
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
                    let stringPosterUrl = URL(string: unwrappedString)
                    if let url = stringPosterUrl
                    {
                        let data = try? Data(contentsOf: url)
                        
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
        self.detailsActivityIndicator.isHidden = true
        self.detailsActivityIndicator.stopAnimating()
        
        
    }
    
    func reachabilityStatusChanged()
    {
        if reachabilityStatus == kNOTREACHABLE
        {
            let noNetworkAlertController = UIAlertController(title: "No Network Connection detected", message: "Cannot conduct search", preferredStyle: .alert)
            
            self.present(noNetworkAlertController, animated: true, completion: nil)
            
            DispatchQueue.main.async { () -> Void in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1.2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: { () -> Void in
                    noNetworkAlertController.dismiss(animated: true, completion: nil)
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
        let savedAlert = UIAlertController.init(title: "Favorite!", message: "\(savedThisMovie) was saved in favorites", preferredStyle: .alert)
        
        let doneAction = UIAlertAction.init(title: "Done", style: .cancel) { (action) in
        }
        savedAlert.addAction(doneAction)
        self.navigationItem.rightBarButtonItem = nil
        self.present(savedAlert, animated: true){
        }
        
        let managedContext = store.managedObjectContext
        
        let addThisMovie = NSEntityDescription.insertNewObject(forEntityName: "Favorite", into: managedContext) as! Favorite
        
        guard let savedMovie = self.movie else {return}
        
        addThisMovie.movies?.insert(savedMovie)
        
        store.saveContext()

 
    }
    
    @IBAction func watchTrailerPressed(_ sender: AnyObject) {
        
        
//         let unwrappedMovie = movie
//         unwrappedMovie
//       
    performSegue(withIdentifier: "trailerSegue", sender: nil)
// 
//        

    
}

    @IBAction func fullPlotDescriptionButton(_ sender: AnyObject)
    {
        //segue: This button will go to Long Plot VC, it just segue...
        // performSegueWithIdentifier("FromDetailToLongSegue", sender: nil)
  
    }
    
    func checkIfTrailerExist()
    {
        if let imdbID = movie?.movieID
        {
            store.api.checkIfAnyTrailersAvailableWithString(imdbID, completion: { (results) in
                if results == []
                {
                    self.trailerButton.isHidden = true
                   // self.trailerPic.isHidden = true
                    
                }
                else if results != []
                {
                      self.trailerButton.isHidden = false
//                    self.trailerPic.isHidden = false
//                    self.trailerPic.image = UIImage.init(named: "trailerButtonLogo.png")
                    
                }
                
            })
            
            
        }
        
        
    }
    
    func checkingStatusCode()
    {
        if let id = movie?.movieID
        {
            store.api.checkIfAnyTrailersAvailableStatusCodeWithString(id, completion: { (code) in
                if code == 34
                {
                    print("no trailer available")
                    self.trailerButton.isHidden = true
                  //  self.trailerPic.isHidden = true
                    
                }
                
            })
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "FromDetailToLongSegue"
        {
            
           // print(movie)
            let destinationLongPlotVC = segue.destination as? LongPlotViewController
            
            if let unwrappedMovie = movie
            {
                
                print(unwrappedMovie)
                destinationLongPlotVC?.movieId = unwrappedMovie.movieID
              
            }
            
        }
            if segue.identifier == "trailerSegue"
            {
                let destinationVC = segue.destination as? TrailerViewController
                
                if let unwrappedMovie = movie
                {
                    destinationVC?.movieTrailer = unwrappedMovie
                }
            }
            
            
    }
    
    }
    



