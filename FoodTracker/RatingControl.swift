//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Herb Chan on 2018-04-11.
//

import UIKit

@IBDesignable  class RatingControl: UIStackView {
    
    // MARK: Properties
    private var ratingButtons = [UIButton]();
    var rating = 0 {
        didSet {
            updateButtonSelectionStates();
        }
    };

    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame);
        setupButtons();
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder);
        setupButtons();
    }
    
    // MARK: Button Action
    @objc func ratingButtonTapped(button: UIButton) {
//        print("Button pressed 👍");
        
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)");
        }
        
        // Calculate the rating of the selected button
        let selectedRating = index + 1;
        
        if selectedRating == rating {
            // If the selected star represents the current rating, reset the rating to 0.
            rating = 0;
        } else {
            // Otherwise set the rating to the selected star
            rating = selectedRating;
        }
    }
    
    // MARK: Setup Buttons
    
    // For accessibility, most is handled by iOS
    // But for Voice Over, you need code it
    // add Accessibility Label
    // add Accessibility Value
    // add Accessibility Hint
    private func setupButtons() {
        
        // clear any existing buttons before creating the new set
        for button in ratingButtons {
            removeArrangedSubview(button);
            button.removeFromSuperview();
        }
        
        ratingButtons.removeAll();
        
        // Load Button Images
        let bundle = Bundle(for: type(of: self));
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection);
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection);
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection);
        
        for index in 0..<starCount {
            // Create the button
            let button = UIButton();
//            button.backgroundColor = UIColor.green;
            
            // set the button images
            button.setImage(emptyStar, for: .normal);
            button.setImage(filledStar, for: .selected);
            button.setImage(highlightedStar, for: .highlighted);
            button.setImage(highlightedStar, for: [.highlighted, .selected]);
            
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false;
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true;
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true;
            
            // Set the Accessibility Label
            button.accessibilityLabel = "Set \(index + 1) star rating";
            
            
            // Setup the button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside);
            
            // Add button to the stack
            addArrangedSubview(button);
            
            // Add the new button to the ratingButtons array
            ratingButtons.append(button);
            
            updateButtonSelectionStates();
        }
    }
    
    // MARK: Properties
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons();
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons();
        }
    }
    
    
    // MARK: helper functions
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            // if the index of a button is less than the rating, that button should be selected
            button.isSelected = index < rating;
            
            // Set the Accessibility Hint String for the currently selected star
            let hintString: String?;
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero.";
            } else {
                hintString = nil;
            }
            
            // Set the Accessibility Value by calculating the value String
            let valueString: String;
            switch (rating) {
            case 0:
                valueString = "No rating set.";
            case 1:
                valueString = "1 star set.";
            default:
                valueString = "\(rating) stars set";
            }
            
            // Assign the Hint String and Value String
            button.accessibilityHint = hintString;
            button.accessibilityValue = valueString;
            
        }
    }
}
