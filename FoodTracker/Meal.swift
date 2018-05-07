//
//  Meal.swift
//  FoodTracker
//
//  Created by Herb Chan on 2018-04-30.
//

import UIKit;

class Meal {
    
    // MARK: Properties
    var name: String;
    var photo: UIImage?;
    var rating: Int;
    
    
    // MARK: Initializer
    // the ? symbol indicates the constructor is failable - that is can throw exceptions
    init?(name: String, photo: UIImage?, rating: Int) {
        // Initialization should fail if there is no name or if the rating is negative
        
        // was...
//        if (name.isEmpty || rating < 0) {
//            return nil;
//        }
        
        // refactored
        // The name must not be empty
        guard !name.isEmpty else {
            return nil;
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil;
        }
        
        self.name = name;
        self.photo = photo;
        self.rating = rating;
    }
}
