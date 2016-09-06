//
//  OmdbAPIClient.swift
//  MovieApp
//
//  Created by Erica on 9/2/16.
//  Copyright © 2016 Erica Gutierrez. All rights reserved.
//

import Foundation


class OmdbAPIClient{
    
  //  static let sharedInstance = OMDBAPIClient()
    
    var movieList = [Movie]()
    
  
    
    func getMoviesFromSearch(title: String) -> () {
        
        // movies by type movie parameter and title
        let callUrl = "https://www.omdbapi.com/?s=\(title)&type=movie&r=json"
       
        
        if let url:String = callUrl {
            let url = NSURL(string: url)
            
           let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url!, completionHandler: { (data, response, error) in
                if error == nil {
                    
                    if let data = data {
                        
                        do {
                            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
                     //  print(jsonResult)
                            
                            if let list = jsonResult["Search"] as? [[String: AnyObject]] {
                                for item in list {
                                    let movie = Movie()
                                    movie.movieTitle = (item["Title"] as? String)!
                                    movie.movieYear = (item["Year"] as? String)!
                                    movie.movieID = (item["imdbID"] as? String)!
                                    movie.moviePosterUrl = (item["Poster"] as? String)!
                                    
                                    self.movieList.append(movie)
                            
                                }
                            }
                            
                            
                        }
                        catch let error as NSError {
                    
                print(error.localizedDescription)
                
                }

}

                }else{
                    print(error!.localizedDescription)
}

})
            task.resume()
}
}
}
