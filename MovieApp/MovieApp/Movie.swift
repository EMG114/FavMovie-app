//
//  Movie.swift
//  MovieApp
//
//  Created by Erica on 9/2/16.
//  Copyright © 2016 Erica Gutierrez. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class Movie: NSManagedObject {

//Insert code here to add functionality to your managed object subclass
    
//    var movieTitle:String = ""
//    var movieYear:String = ""
//    var movieDirector:String = ""
//    var movieWriter:String = ""
//    var movieActors:String = ""
//    var movieID:String = ""
//    var moviePosterUrl:String = ""
//    var movieRated:String = ""
//    var movieLanguage:String = ""
//    var movieCountry:String = ""
//    var movieGenre:String = ""
//    var movieMetascore: String = ""
//    var movieRating:String = ""
//    var moviePlotShort:String = ""
//    var movieRuntime:String = ""
//    var movieLongPlot:String = ""
//    
    convenience init?(movieDict: NSDictionary,entity: NSEntityDescription, managedObjectContext: NSManagedObjectContext)
    {
        self.init(entity: entity, insertInto: managedObjectContext)

   
    //init?(movieDict:[String: AnyObject]){
       
        if let title = movieDict["Title"] as? String {
             let year = movieDict["Year"] as? String
             let id = movieDict["imdbID"] as? String
             let posterUrl = movieDict["Poster"] as? String
            
            
            
            self.movieTitle = title
            self.movieYear = year!
            self.movieID = id!
            self.moviePosterUrl = posterUrl!
           // print(posterUrl)
           // print(self.moviePosterUrl)
            
        } else {
            return nil
        }
        

    }
            
 func populateDetailsViewController(_ movieDataDictionary: NSDictionary, completion:(Bool) -> ())
        {
            self.moviePlotShort = (movieDataDictionary["Plot"] as? String)!
            self.movieActors = (movieDataDictionary["Actors"] as? String)!
            self.movieYear = (movieDataDictionary["Year"] as? String)!
            self.movieDirector = (movieDataDictionary["Director"] as? String)!
            self.movieWriter = (movieDataDictionary["Writer"] as? String)!
            self.movieRating = (movieDataDictionary["imdbRating"] as? String)!
            self.movieMetascore = (movieDataDictionary["Metascore"] as? String)!
            self.movieLanguage = (movieDataDictionary["Language"] as? String)!
            self.movieCountry = (movieDataDictionary["Country"] as? String)!
            self.movieRated = (movieDataDictionary["Rated"] as? String)!
            self.movieGenre = (movieDataDictionary["Genre"] as? String)!
            self.movieRuntime = (movieDataDictionary["Runtime"] as? String)!
           // self.movieRating = (movieDataDictionary["Rating"] as? String)!

            
            completion(true)
        }

                
        
func longPlotDescription(_ movieLongPlotDictionary: NSDictionary, completion:(Bool) -> ()) {
            self.movieLongPlot = (movieLongPlotDictionary["Plot"] as? String)!
            completion(true)
        }

    
    }
    



