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
    
    var upcomingMovie : [UpcomingMovies] = []
    
    
    
    func getNextPage()
    {
        pageNumber += 1
        
    }
    
    
    func getMoviesFromSearch(_ title: String, pages: Int, completionHandler:@escaping ([String: AnyObject]) -> () ){
        
        // movies by type movie parameter and title with json response
        let callUrl = "https://www.omdbapi.com/?s=\(title)&page=\(pages)&type=movie&r=json"
        
        
        if let url:String = callUrl {
            let url = URL(string: url)
            
            let session = URLSession.shared
            let task = session.dataTask(with: url!, completionHandler: { (data, response, error) in
                
               // print(data)
               // print(response)
                
                if let data = data {
                    
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
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
    
    
    
    
    func getMovieDataSearchByID(_ movieID: String, completion: @escaping (NSDictionary)-> ())
    {
        let urlString = "https://www.omdbapi.com/?i=\(movieID)&plot=short"
        let url = URL(string: urlString)
        
        guard let unwrappedURL = url else {return}
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: unwrappedURL, completionHandler: { (data, response, error) in
            //            print(data)
            //            print(response)
            //            print(error)
            
            guard let unwrappedData = data else {return}
            
            do{
                
                //  NSJSONReadingAllowFragments
                //Specifies that the parser should allow top-level objects that are not an instance of NSArray or NSDictionary
                
                let jsonmovieData = try JSONSerialization.jsonObject(with: unwrappedData, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
                //print(jsonmovieData)
                if let movieDataDictionary = jsonmovieData
                {
                    completion(movieDataDictionary as! [String : AnyObject] as NSDictionary)
                }
            }
            catch
            {
                print(error)
                
            }
        }) 
        task.resume()
        
    }
    
    
    
    
    func getMovieLongPlot(_ movieID: String, completion: @escaping (String)->())
    {
        
        // print("Whats the movie id: \(movieID)")
        let urlString = "https://www.omdbapi.com/?i=\(movieID)&plot=full&r=json"
        
        let url = URL(string: urlString)
        
        guard let unwrappedURL = url else {return}
        
        let session = URLSession.shared
  
        let task = session.dataTask(with: unwrappedURL, completionHandler: { (data, response, error) in
      
            guard let unwrappedData = data else {return}
            
            
            do{
                
             
                let jsonmovieLongPlot = try JSONSerialization.jsonObject(with: unwrappedData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String : AnyObject]
                
                
                if let movieLongPlotDictionary = jsonmovieLongPlot
                    
                {
                
                    
                    if let unwrappedPlot = movieLongPlotDictionary["Plot"]{
              
                        completion( unwrappedPlot as! String)
                    }
                    
                   
                }
            }
            catch let error as NSError
            {
                print(error.localizedDescription)
            }
        }) 
        task.resume()
        
    }
    func getMoviesPlayingInTheaters(_ completion: @escaping (NSArray)->())
    {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let urlString = "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)"
        
        let url = URL(string: urlString)
        
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            guard let unwrappedData = data else {return}
            
            do{
                let upcomingMovie = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as! NSDictionary
                
                let moviesArray = upcomingMovie["results"] as? NSArray
                
                guard let unwrappedMovies = moviesArray else {return}
                
                for movie in unwrappedMovies
                {
                    let movieDict = UpcomingMovies.init(dictionary: movie as! NSDictionary)
                    self.upcomingMovie.append(movieDict)
                    completion(unwrappedMovies)
                }
                
            }
            catch
            {
                print("did i crash?")
            }
        })
        dataTask.resume()
        
    }
    
    func movieTrailerAPI(_ ID: Int, completion: @escaping (String)->())
    {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let urlString = "https://api.themoviedb.org/3/movie/\(ID)/videos?api_key=\(apiKey)"
        
        let url = URL(string: urlString)
        
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            guard let unwrappedData = data else {return}
            
            do{
                let upcomingMovie = try JSONSerialization.jsonObject(with: unwrappedData, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                
                let moviesTrailers = upcomingMovie["results"] as? NSArray
                
                guard let unwrappedMovies = moviesTrailers?.firstObject else {return}
                
                let firstMovie = unwrappedMovies as! NSDictionary
                
                let movieKey = firstMovie["key"] as? String
                guard let key = movieKey else {return}
                
                completion(key)
                
            }
            catch
            {
                print("did i crash?")
            }
        })
        dataTask.resume()
    }
    
    func movieTrailerAPIWithString(_ ID: String, completion: @escaping (String)->())
    {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let urlString = "https://api.themoviedb.org/3/movie/\(ID)/videos?api_key=\(apiKey)"
        
        let url = URL(string: urlString)
        
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            guard let unwrappedData = data else {return}
            
            do{
                let upcomingMovie = try JSONSerialization.jsonObject(with: unwrappedData, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                
                let moviesTrailers = upcomingMovie["results"] as? NSArray
                
                guard let unwrappedMovies = moviesTrailers?.firstObject else {return}
                
                let firstMovie = unwrappedMovies as! NSDictionary
                
                let movieKey = firstMovie["key"] as? String
                guard let key = movieKey else {return}
                
                completion(key)
                
            }
            catch
            {
                print("error")
            }
        })
        dataTask.resume()
    }
    
    
    func checkIfAnyTrailersAvailable(_ ID: Int, completion: @escaping (NSArray)->())
    {
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let urlString = "https://api.themoviedb.org/3/movie/\(ID)/videos?api_key=\(apiKey)"
        
        let url = URL(string: urlString)
        
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            guard let unwrappedData = data else {return}
            
            do{
                let upcomingMovie = try JSONSerialization.jsonObject(with: unwrappedData, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                
                let moviesTrailers = upcomingMovie["results"] as? NSArray
                
                guard let unwrappedMovies = moviesTrailers else {return}
                
                completion(unwrappedMovies)
                
            }
            catch
            {
                print("did i crash?")
            }
        })
        dataTask.resume()
    }
    
    
    func checkIfAnyTrailersAvailableWithString(_ ID: String, completion: @escaping (NSArray)->())
    {
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let urlString = "https://api.themoviedb.org/3/movie/\(ID)/videos?api_key=\(apiKey)"
        
        let url = URL(string: urlString)
        
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            guard let unwrappedData = data else {return}
            
            do{
                let upcomingMovie = try JSONSerialization.jsonObject(with: unwrappedData, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                
                let moviesTrailers = upcomingMovie["results"] as? NSArray
                
                guard let unwrappedMovies = moviesTrailers else {return}
                
                completion(unwrappedMovies)
                
            }
            catch
            {
                print("did i crash?")
            }
        })
        dataTask.resume()
    }
    
    func checkIfAnyTrailersAvailableStatusCodeWithString(_ ID: String, completion: @escaping (Int)->())
    {
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let urlString = "https://api.themoviedb.org/3/movie/\(ID)/videos?api_key=\(apiKey)"
        
        let url = URL(string: urlString)
        
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            guard let unwrappedData = data else {return}
            
            do{
                let upcomingMovie = try JSONSerialization.jsonObject(with: unwrappedData, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                
                let moviesTrailers = upcomingMovie["status_code"] as? Int
                
                guard let unwrappedMovies = moviesTrailers else {return}
                
                completion(unwrappedMovies)
                
            }
            catch
            {
                print("did i crash?")
            }
        })
        dataTask.resume()
    }
    
    func checkIfAnyTrailersAvailableStatusCodeWithInt(_ ID: Int, completion: @escaping (Int)->())
    {
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let urlString = "https://api.themoviedb.org/3/movie/\(ID)/videos?api_key=\(apiKey)"
        
        let url = URL(string: urlString)
        
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            guard let unwrappedData = data else {return}
            
            do{
                let upcomingMovie = try JSONSerialization.jsonObject(with: unwrappedData, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                
                let moviesTrailers = upcomingMovie["status_code"] as? Int
                
                guard let unwrappedMovies = moviesTrailers else {return}
                
                completion(unwrappedMovies)
                
            }
            catch
            {
                print("did i crash?")
            }
        })
        dataTask.resume()
    }
}
