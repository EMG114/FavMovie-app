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
 let api = OmdbAPIClient.sharedStore
    
 var movieList:[Movie] = []
 var favoriteList = [Favorite]()

    
    
 fileprivate init() {}
    
    func searchForMovie(_ title:String,pages: Int, completionHandler:@escaping (Bool)->()) {
        
        OmdbAPIClient().getMoviesFromSearch(title, pages: pages) { jsonResult in
         
            
            if let list = jsonResult["Search"] as? [[String: AnyObject]] {
                for movieDict in list {
                    
                    let movieEntity = NSEntityDescription.entity(forEntityName: "Movie", in: self.managedObjectContext)
                    
                    guard let entity = movieEntity else {fatalError("there is an error")}
                    

                    if let movie = Movie.init(movieDict:movieDict as NSDictionary, entity:entity, managedObjectContext: self.managedObjectContext){
                    
                        
                        movie.movieTitle = (movieDict["Title"] as? String)!//String(
                        movie.movieYear = (movieDict["Year"] as? String)!
                        movie.movieID = (movieDict["imdbID"] as? String)!
                        movie.moviePosterUrl = (movieDict["Poster"] as? String)!
                        
                     
                        self.movieList.append(movie)
                    }

                }
                completionHandler(true)
            }
            
            
        }
   
        

        
    }
    
    //movieID:String
    func getDetailsForMovieByID(_ movie: Movie, completion:@escaping ()->()){
        
        OmdbAPIClient().getMovieDataSearchByID(movie.movieID!){ movieDataDictionary in
            movie.populateDetailsViewController(movieDataDictionary, completion: { success in
                if success {
                    
                    
                    
                    completion()
                    
                    
                }
            })
            
        }
        
    }
    
    
    
    func getLongSummaryPlot(_ movie: String, completion:@escaping (String)->())
    {
        
        _ = ""
    
        OmdbAPIClient().getMovieLongPlot(movie) { (plot) in
            
            
            
            if plot != ""{
                completion(plot)
            }
            
        }
        
        
    }
    
   
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.ericagutierrez.MovieApp" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "MovieApp", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("MovieApp.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
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
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    
    func fetchData()
    {
        
        let favoriteRequest = NSFetchRequest<Favorite>(entityName: "Favorite")
        
        do{
            favoriteList = try managedObjectContext.fetch(favoriteRequest)
        }
        catch
        {
            print(error)
            favoriteList = []
        }
        
    }

    
//    func fetchData()
//    {
//        
//        let favoriteFetch = NSFetchRequest(entityName: "Favorite")
//        
//        do{
//            self.favoriteList = try managedObjectContext.fetch(favoriteFetch) as! [Favorite]
//        }
//        catch
//        {
//            print(error)
//            favoriteList = []
//        }
//        
//    }

    
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





