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
    
    @IBOutlet weak var moviePlot: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var imbdScoreLabel: UILabel!
    @IBOutlet weak var metaScoreLabel: UILabel!
    
//    override func viewDidLoad()
//    {
//        super.viewDidLoad()
//        
//        guard let unwrappedMovie = movie else {return}
//        self.store.getDetailsForMovieByID(movie., completion: {
//            //<#code#>
//        })(unwrappedMovie)
//        {
//            dispatch_async(dispatch_get_main_queue(),{
//                
//                self.moviePlot.text = self.movie?.plot
//                self.releasedLabel.text = self.movie?.released
//                self.directorLabel.text = self.movie?.director
//                self.writerLabel.text = self.movie?.writer
//                self.starsLabel.text = self.movie?.actors
//                self.imbdScoreLabel.text = self.movie?.imdbRating
//                self.metaScoreLabel.text = self.movie?.metaScore
//                
//                
//                let imageString = self.movie?.poster
//                
//                if let unwrappedString = imageString
//                {
//                    let stringPosterUrl = NSURL(string: unwrappedString)
//                    if let url = stringPosterUrl
//                    {
//                        let dtinternet = NSData(contentsOfURL: url)
//                        
//                        if let unwrappedImage = dtinternet
//                        {
//                            self.posterImageView.image = UIImage.init(data: unwrappedImage)
//                        }
//                    }
//                    
//                }
//                
//            })
//            
//        }
//        
//    }
    
    @IBAction func plotDescriptionButton(sender: AnyObject)
    {
        //segue
    }
    
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
//    {
//        if segue.identifier == "fullSummarySegue"
//        {
//            let destinationFullPlotVC = segue.destinationViewController as? FullPlotViewController
//            
//            if let unwrappedMovie = movie
//            {
//                destinationFullPlotVC?.movie = unwrappedMovie
//            }
//            
//        }
//        
//    }
    
    

}
