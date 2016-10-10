//
//  OmdbAPIClient.swift
//  MovieApp
//
//  Created by Erica on 9/2/16.
//  Copyright © 2016 Erica Gutierrez. All rights reserved.
//

import Foundation


class OmdbAPIClient{
    
    
    static let sharedStore = OmdbAPIClient()
    
    var pageNumber = 1
    
    
    
    func getNextPage()
    {
        pageNumber += 1
        
    }
    
    
    func getMoviesFromSearch(title: String, pages: Int, completionHandler:([String: AnyObject]) -> () ){
        
        // movies by type movie parameter and title with json response
        let callUrl = "https://www.omdbapi.com/?s=\(title)&page=\(pages)&type=movie&r=json"
        
        
        if let url:String = callUrl {
            let url = NSURL(string: url)
            
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url!, completionHandler: { (data, response, error) in
                
               // print(data)
               // print(response)
                
                if let data = data {
                    
                    do {
                        let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
                        //print(jsonResult)
                        completionHandler(jsonResult as! [String : AnyObject])
                        
                    }
                    catch let error as NSError {
                        
                        print(error.localizedDescription)
                        
                    }
                    
                }
                
            })
            task.resume()
        }
    }
    
    
    
    
    func getMovieDataSearchByID(movieID: String, completion: (NSDictionary)-> ())
    {
        let urlString = "https://www.omdbapi.com/?i=\(movieID)&plot=short"
        let url = NSURL(string: urlString)
        
        guard let unwrappedURL = url else {return}
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(unwrappedURL) { (data, response, error) in
            //            print(data)
            //            print(response)
            //            print(error)
            
            guard let unwrappedData = data else {return}
            
            do{
                
                //  NSJSONReadingAllowFragments
                //Specifies that the parser should allow top-level objects that are not an instance of NSArray or NSDictionary
                
                let jsonmovieData = try NSJSONSerialization.JSONObjectWithData(unwrappedData, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
                //print(jsonmovieData)
                if let movieDataDictionary = jsonmovieData
                {
                    completion(movieDataDictionary as! [String : AnyObject])
                }
            }
            catch
            {
                print(error)
                
            }
        }
        task.resume()
        
    }
    
    
    
    
    func getMovieLongPlot(movieID: String, completion: (String)->())
    {
        
        // print("Whats the movie id: \(movieID)")
        let urlString = "https://www.omdbapi.com/?i=\(movieID)&plot=full&r=json"
        
        let url = NSURL(string: urlString)
        
        guard let unwrappedURL = url else {return}
        
        let session = NSURLSession.sharedSession()
  
        let task = session.dataTaskWithURL(unwrappedURL) { (data, response, error) in
      
            guard let unwrappedData = data else {return}
            
            
            do{
                
             
                let jsonmovieLongPlot = try NSJSONSerialization.JSONObjectWithData(unwrappedData, options: NSJSONReadingOptions.AllowFragments) as? [String : AnyObject]
                
                
                if let movieLongPlotDictionary = jsonmovieLongPlot
                    
                {
                
                    
                    if let unwrappedPlot = movieLongPlotDictionary["Plot"]{
              
                        completion(String(unwrappedPlot))
                    }
                    
                   
                }
            }
            catch let error as NSError
            {
                print(error.localizedDescription)
            }
        }
        task.resume()
        
    }
    
    
}
