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
        


    
    

}

}