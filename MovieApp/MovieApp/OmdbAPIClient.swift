//
//  OmdbAPIClient.swift
//  MovieApp
//
//  Created by Erica on 9/2/16.
//  Copyright © 2016 Erica Gutierrez. All rights reserved.
//

import Foundation


class OmdbAPIClient{
    
    
    //static let sharedStore = OmdbAPIClient()
    
    var pageNumber = 1
    
    func getNextPage()
    {
        pageNumber += 1
    }
    
    
    class func getMoviesFromSearch(title: String, completionHandler:([String: AnyObject]) -> () ){
        
        // movies by type movie parameter and title
        let callUrl = "https://www.omdbapi.com/?s=\(title)&type=movie&page&r=json"
       
        
        if let url:String = callUrl {
            let url = NSURL(string: url)
            
           let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url!, completionHandler: { (data, response, error) in
        
                    if let data = data {
                        
                        do {
                            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
                          //  print(jsonResult)
                            completionHandler(jsonResult as! [String : AnyObject])
                            
                          //  print(jsonResult["Title"] as? String)!
//                            movie.movieYear = (movieDict["Year"] as? String)!
//                            movie.movieID = (movieDict["imdbID"] as? String)!
//                            movie.moviePosterUrl = (movieDict["Poster"] as? String)!
                            
                            
        
                        }
                        catch let error as NSError {
                    
                print(error.localizedDescription)
                
                }

}

})
            task.resume()
}
}
    
    
    
    
   class func getMovieDataSearchByID(movieID: String, completion: (NSDictionary)-> ())
    {
        let urlString = "https://www.omdbapi.com/?i=\(movieID)"
        let url = NSURL(string: urlString)
        
        guard let unwrappedURL = url else {return}
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(unwrappedURL) { (data, response, error) in
            
            guard let unwrappedData = data else {return}
            
            do{
                
                //  NSJSONReadingAllowFragments
                //Specifies that the parser should allow top-level objects that are not an instance of NSArray or NSDictionary
                
                let jsonmovieData = try NSJSONSerialization.JSONObjectWithData(unwrappedData, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
                
                if let movieDataDictionary = jsonmovieData
                {
                    completion(movieDataDictionary)
                }
            }
            catch
            {
                print(error)
            }
        }
        task.resume()
        
    }
    
    
    
    
    
    
    
}
