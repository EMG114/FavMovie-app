//
//  Favorite+CoreDataProperties.swift
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

extension Favorite {

    @NSManaged var movies: Set<Movie>?

}
