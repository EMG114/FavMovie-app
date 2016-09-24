//
//  MovieDataStore.swift
//  MovieApp
//
//  Created by Erica on 9/7/16.
//  Copyright © 2016 Erica Gutierrez. All rights reserved.
//

import Foundation
import CoreData


class MovieDataStore {
    
 static let sharedStore = MovieDataStore()
 
 var movieList:[Movie] = []
 var favoriteList = [Favorite]()
 var pageNumber = 1
    

    
    
    
    func getNextPage(searchText: String)
    {
        pageNumber += 1
        
    }
    
    
 private init() {}
    
    func searchForMovie(title:String,page: Int, completionHandler:(Bool)->()) {
        
        OmdbAPIClient().getMoviesFromSearch(title, pages: pageNumber) { jsonResult in
            self.movieList.removeAll()
            
            if let list = jsonResult["Search"] as? [[String: AnyObject]] {
                for movieDict in list {
                    
                    let movieEntity = NSEntityDescription.entityForName("Movie", inManagedObjectContext: self.managedObjectContext)
                    
                    guard let entity = movieEntity else {fatalError("there is an error")}
                    
//                    let repository = Movie(movieDict: movieDict, entity:entity , managedObjectContext: self.managedObjectContext)
                    
                    if let movie = Movie.init(movieDict:movieDict, entity:entity, managedObjectContext: self.managedObjectContext){
                    
                        
                        movie.movieTitle = (movieDict["Title"] as? String)!
                        movie.movieYear = (movieDict["Year"] as? String)!
                        movie.movieID = (movieDict["imdbID"] as? String)!
                        movie.moviePosterUrl = (movieDict["Poster"] as? String)!
                        
                        //
                        //print("***************************************************************************")
                        //                        print("Movie Title: \(movie.movieTitle)")
                        //                        print("Movie Year: \(movie.movieYear)")
                        //                        print("Movie ImdbID: \(movie.movieID)")
                        //                        print("Movie PosterURL: \(movie.moviePosterUrl)")
                        //print("***************************************************************************")
                        //
                        self.movieList.append(movie)
                    }
                    
                    
                    completionHandler(true)
                    
                }
            }
            
            
            
            if self.movieList.count > 0 {
                
                completionHandler(true)}
        }
        
        
        
        
        
    }
    //movieID:String
    func getDetailsForMovieByID(movie: Movie, completion:()->()){
        
        OmdbAPIClient().getMovieDataSearchByID(movie.movieID!){ movieDataDictionary in
            movie.populateDetailsViewController(movieDataDictionary, completion: { success in
                if success {
                    
                    
                    //            if let movie = Movie.init(movieDict:movieDataDictionary as! [String : AnyObject]){
                    //
                    //               movie.movieID = (movieDataDictionary["imdbID"] as? String)!
                    //               movie.moviePosterUrl = (movieDataDictionary["Poster"] as? String)!
                    //               movie.movieTitle = (movieDataDictionary["Title"] as? String)!
                    //               movie.movieYear = (movieDataDictionary["Year"] as? String)!
                    //                movie.moviePlotShort = (movieDataDictionary["Plot"] as? String)!
                    //                movie.movieGenre = (movieDataDictionary["Genre"] as? String)!
                    //                movie.movieDirector = (movieDataDictionary["Director"] as? String)!
                    //                movie.movieActors = (movieDataDictionary["Actors"] as? String)!
                    //                movie.movieLanguage = (movieDataDictionary["Language"] as? String)!
                    //                movie.movieCountry = (movieDataDictionary["Country"] as? String)!
                    //                movie.movieMetascore = (movieDataDictionary["Metascore"] as? String)!
                    //                movie.movieRated = (movieDataDictionary["Rated"] as? String)!
                    //           //     movie.movieRating = (movieDataDictionary["Rating"] as? String)!
                    //                movie.movieRuntime = (movieDataDictionary["Runtime"] as? String)!
                    
                    //  print("***************************************************************************")
                    //
                    //                print("Movie Title: \(movie.movieTitle)")
                    //                print("Movie Year: \(movie.movieYear)")
                    //                print("Movie Genre: \(movie.movieGenre)")
                    //                print("Movie Director: \(movie.movieDirector)")
                    //                print("Movie Actors: \(movie.movieActors)")
                    //                print("Movie Language: \(movie.movieLanguage)")
                    //                print("Movie Country: \(movie.movieCountry)")
                    //                print("Movie Metascore: \(movie.movieMetascore)")
                    //                print("Movie plotShort: \(movie.moviePlotShort)")
                    //                print("Movie Rating: \(movie.movieRating)")
                    //                print("Movie Rated: \(movie.movieRated)")
                    //                print("Movie Runtime: \(movie.movieRuntime)")
                    // print("***************************************************************************")
                    ////
                    
                    
                    
                    
                    completion()
                    
                    
                }
            })
            
        }
        
    }
    
    
    
    func getLongSummaryPlot(movie: String, completion:(String)->())
    {
        
        _ = ""
        print("I am getting called and my movie is \(movie)")
        // make OmdbAPIClient into a class function
        OmdbAPIClient().getMovieLongPlot(movie) { (plot) in
            
            
            
            if plot != ""{
                completion(plot)
            }
            
        }
        
        
        
//        OmdbAPIClient().getMovieLongPlot(movie) { (moviePlot) in
//            moviePlotString = moviePlot
//            
//            if moviePlot != ""{
//                completion(moviePlotString)
//            }
//        }
        
        
        
        
        //        OmdbAPIClient().getMovieLongPlot(movie) { (movieLongPlotDictionary) in
        //   
        //            movie.longPlotDescription(movieLongPlotDictionary, completion: { successful in
        //                 if successful {
        //                
        //            completion()
        //        }
        
        
        
    }
    
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.ericagutierrez.MovieApp" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("MovieApp", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("MovieApp.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    
    func fetchData()
    {
        
        let favoriteFetch = NSFetchRequest(entityName: "Favorite")
        
        do{
            self.favoriteList = try managedObjectContext.executeFetchRequest(favoriteFetch) as! [Favorite]
        }
        catch
        {
            print(error)
            favoriteList = []
        }
        
    }

    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    
    
    }





