//
//  UpcomingMovies.swift
//  MovieApp
//
//  Created by Erica on 10/10/16.
//  Copyright © 2016 Erica Gutierrez. All rights reserved.
//

import Foundation

class UpcomingMovies
{
    var title: String?
    var poster: String?
    var releaseDate: String?
    var plot : String?
    var id : String?
    
    
    init(dictionary: NSDictionary)
    {
        if let moviePoster = dictionary["poster_path"]
        {
            self.poster = moviePoster as? String
        }
        else
        {
            self.poster = "movie-placeholder.png"
        }
        if let movieTitle = dictionary["title"]
        {
            self.title = movieTitle as? String
        }
        if let movieDate = dictionary["release_date"]
        {
            self.releaseDate = movieDate as? String
        }
        if let moviePlot = dictionary["overview"]
        {
            self.plot = moviePlot as? String
        }
        if let movieID = dictionary["id"]
        {
            self.id = movieID as? String
        }
        else
        {
            fatalError("Error")
        }
        
        
    }
    
}
