//
//  YouTubeAPIClient.swift
//  MovieApp
//
//  Created by Erica on 10/9/16.
//  Copyright © 2016 Erica Gutierrez. All rights reserved.
//

import Foundation




class YouTubeAPIClient {
    
  static let sharedYTstore = YouTubeAPIClient()
    
    
    
//private static var urlString: String = "https://www.googleapis.com/youtube/v3/search"
 
var type = ["channel", "video", "playlist"]
    
//var channelID = "UCTCjFFoX1un-j7ni4B6HJ3Q"
    
// let searchText = "\(movie.movieTitle) +  \(movie.movieYear) + Official Trailer"
    
 func getSearches(index: Int, searchText: String, completion: [String : String] -> Void) {   
   
    let urlString = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=\(searchText)&type=video&key=\(Secrets.youtubeApiKey)"
    
    let url = NSURL(string: urlString)
    
    guard let unwrappedURL = url else {return}
    
    let session = NSURLSession.sharedSession()
    
    let task = session.dataTaskWithURL(unwrappedURL) { (data, response, error) in
        
        print("this is my data: \(data)")
        guard let unwrappedData = data else {return}
        
        
        do{
            
            
            let jsonYoutube = try NSJSONSerialization.JSONObjectWithData(unwrappedData, options: NSJSONReadingOptions.AllowFragments) as? [String : AnyObject]
            
            
            if let youtubeDict = jsonYoutube
                
            {
                
                
            //    if let unwrappedYoutubeData = youtubeDict["VideoID"]{
                    
                    completion(youtubeDict as! [String : String])
           //     }
                
                
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