//
//  Movie.swift
//  MovieApp
//
//  Created by Erica on 9/2/16.
//  Copyright © 2016 Erica Gutierrez. All rights reserved.
//

import UIKit
import Foundation

class Movie {

    
    var movieTitle:String = ""
    var movieYear:String = ""
    var movieDirector:String = ""
    var movieWriter:String = ""
    var movieActors:String = ""
    var movieID:String = ""
    var moviePosterUrl:String = ""
    var movieRated:String = ""
    var movieLanguage:String = ""
    var movieCountry:String = ""
    var movieGenre:String = ""
    var movieMetascore: String = ""
    var movieRating:String = ""
    var moviePlotShort:String = ""
    var movieRuntime:String = ""
    
    
    
    init?(movieDict:[String: AnyObject]){
       
        if let title = movieDict["Title"] as? String {
             let year = movieDict["Year"] as? String
             let id = movieDict["imdbID"] as? String
             let posterUrl = movieDict["Poster"] as? String
            
            
            
            self.movieTitle = title
            self.movieYear = year!
            self.movieID = id!
            self.moviePosterUrl = posterUrl!
            
            
        } else {
            return nil
        }
        

        
            
        func populateDetailsViewController(dictionary: NSDictionary, completion:(Bool) -> ())
        {
            self.moviePlotShort = (dictionary["Plot"] as? String)!
            self.movieActors = (dictionary["Actors"] as? String)!
            self.movieYear = (dictionary["Released"] as? String)!
            self.movieDirector = (dictionary["Director"] as? String)!
            self.movieWriter = (dictionary["Writer"] as? String)!
            self.movieRating = (dictionary["imdbRating"] as? String)!
            self.movieMetascore = (dictionary["Metascore"] as? String)!
            
            completion(true)
        }

                
        
        func LongPlotDescription(dictionary: NSDictionary, completion:(Bool)->())
        {
            self.moviePlotShort = (dictionary["Plot"] as? String)!
            completion(true)
        }

    
            }
    
}
    

