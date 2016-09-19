//
//  Movie+CoreDataProperties.swift
//  MovieApp
//
//  Created by Erica on 9/19/16.
//  Copyright © 2016 Erica Gutierrez. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Movie {

    @NSManaged var movieActors: String?
    @NSManaged var movieCountry: String?
    @NSManaged var movieDirector: String?
    @NSManaged var movieGenre: String?
    @NSManaged var movieID: String?
    @NSManaged var movieLanguage: String?
    @NSManaged var movieLongPlot: String?
    @NSManaged var movieMetascore: String?
    @NSManaged var moviePlotShort: String?
    @NSManaged var moviePosterUrl: String?
    @NSManaged var movieRated: String?
    @NSManaged var movieRating: String?
    @NSManaged var movieRuntime: String?
    @NSManaged var movieTitle: String?
    @NSManaged var movieWriter: String?
    @NSManaged var movieYear: String?
    @NSManaged var favorite: Favorite?

}
