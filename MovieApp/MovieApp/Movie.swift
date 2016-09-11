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
    var moviePlot:String = ""
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

}
//    
//    enum MoviePlot:String {
//        case plotShort, plotLong
//        
//        }
//        
//    
//    
//
//    
//    func moviePlotDescription(i: MoviePlot){
//        // i: Handle the enum argument in a func.
//        if i == .plotShort {
//            return
//            
//        
//        } else if i == .plotLong {
//                
//            print("Long")
//        }
//        else {
//            print("No Plot")
//        }
//    }
  
    
    

}