//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Herb Chan on 2018-03-05.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    // MARK: Meal Class Tests
    
    // Confirm that the Meal initializer returns a Meal object when apssed valid parameters
    func testMealInitializationSucceeds() {
        
        // Zero rating
        let zeroRatingMeal = Meal.init(name: "Zedro", photo: nil, rating: 0);
        XCTAssertNotNil(zeroRatingMeal);
        
        // Highest positive rating
        let positiveRatingMeal = Meal.init(name: "Positive", photo: nil, rating: 5);
        XCTAssertNotNil(positiveRatingMeal);
    }
    
    // Confirm that the Meal initalizer returns nil when passed a negative rating or an empty name
    func testMealInitializationFails() {
        
        // Negative rating
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1);
        XCTAssertNil(negativeRatingMeal);
        
        // Rating exceeds maximum
        let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6);  // should fail.  ArrayIndexOutOfBounds exception in Java
        XCTAssertNil(largeRatingMeal);
        
        // Empty string
        let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0);
        XCTAssertNil(emptyStringMeal);
    }
}
