//
//  MovieDataStore.swift
//  MovieApp
//
//  Created by Erica on 9/7/16.
//  Copyright © 2016 Erica Gutierrez. All rights reserved.
//

import Foundation


class MovieDataStore {
    
 static let sharedStore = MovieDataStore()
 var movieList:[Movie] = []
 private init() {}

    func searchForMovie(title:String, completionHandler:(Bool)->()) {
        
        OmdbAPIClient.getMoviesFromSearch(title) { jsonResult in
            self.movieList.removeAll()
        
            if let list = jsonResult["Search"] as? [[String: AnyObject]] {
                for movieDict in list {
                    if let movie = Movie.init(movieDict:movieDict){
                        
                        
      movie.movieTitle = (movieDict["Title"] as? String)!
      movie.movieYear = (movieDict["Year"] as? String)!
      movie.movieID = (movieDict["imdbID"] as? String)!
      movie.moviePosterUrl = (movieDict["Poster"] as? String)!
                            
                        
print("***************************************************************************")
                        print("Movie Title: \(movie.movieTitle)")
                        print("Movie Year: \(movie.movieYear)")
                        print("Movie ImdbID: \(movie.movieID)")
                        print("Movie PosterURL: \(movie.moviePosterUrl)")
print("***************************************************************************")

                    self.movieList.append(movie)
                    }
                   
                    
                   completionHandler(true)
            
                    }
            }
            

        
          if self.movieList.count > 0 {
            
            completionHandler(true)}
    }
    
    
    
    
    
}

    func getDetailsForMovieByID(movieID:String, completion:(Bool)){
        
        OmdbAPIClient.getMovieDataSearchByID(movieID){ movieDataDictionary in
            
           // self.movieList.removeAll()
            
            if let movie = Movie.init(movieDict:movieDataDictionary as! [String : AnyObject]){
                
              //  movie.movieID = (movieDataDictionary["imdbID"] as? String)!
            //    movie.moviePosterUrl = (movieDataDictionary["Poster"] as? String)!
            //    movie.movieTitle = (movieDataDictionary["Title"] as? String)!
           //     movie.movieYear = (movieDataDictionary["Year"] as? String)!
                movie.moviePlot = (movieDataDictionary["Plot"] as? String)!
                movie.movieGenre = (movieDataDictionary["Genre"] as? String)!
                movie.movieDirector = (movieDataDictionary["Director"] as? String)!
                movie.movieActors = (movieDataDictionary["Actors"] as? String)!
                movie.movieLanguage = (movieDataDictionary["Language"] as? String)!
                movie.movieCountry = (movieDataDictionary["Country"] as? String)!
                movie.movieMetascore = (movieDataDictionary["Metascore"] as? String)!
                movie.movieRated = (movieDataDictionary["Rated"] as? String)!
                movie.movieRating = (movieDataDictionary["Rating"] as? String)!
                movie.movieRuntime = (movieDataDictionary["Runtime"] as? String)!
                
                print("Movie Genre: \(movie.movieGenre)")
                print("Movie Director: \(movie.movieDirector)")
                print("Movie Actors: \(movie.movieActors)")
                print("Movie Language: \(movie.movieLanguage)")
                print("Movie Country: \(movie.movieCountry)")
                print("Movie Metascore: \(movie.movieMetascore)")
                print("Movie plotShort: \(movie.moviePlot)")
                print("Movie Rating: \(movie.movieRating)")
                print("Movie Rated: \(movie.movieRated)")
                print("Movie Runtime: \(movie.movieRuntime)")
            
                completion
                
            }
         
        
            
              
               }
    
            
       
    
}
    
}