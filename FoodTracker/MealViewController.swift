//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Herb Chan on 2018-03-05.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
     This value is either passed by `MealTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new meal
    */
    var meal: Meal?;
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the TextField's user input through delegate callbacks
        nameTextField.delegate = self;
        
        // update the save button until the user enters in a valid name
        updateSaveButtonState();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disbale the Save button while editing
        saveButton.isEnabled = false;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        // Enable the Save button when finished editing
        updateSaveButtonState();  // Update the Save button state
        navigationItem.title = nameTextField.text;  // Update the title with the name of the food menu item
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder();
        return true;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Update the mealNameLabel with what the user entered
        
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user cancelled
        dismiss(animated: true, completion: nil);
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // The info dictionary may contain multiple representations of the image.  Yuu want to use the original
        // The info dictionary always contains the original image that was selected in the picker.  It can also hold an edited version
        // We want to use the original in this case.
        // This closure assumes unwrapping the optional object returned by the dictionary and casts it as an UIImage
        // If it fails, there is something really wrong, so we console an error
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)");
        }
        
        // Set the photoImageView to display the selected image
        photoImageView.image = selectedImage;
        
        // Dismiss the picker
        dismiss(animated: true, completion: nil);
        
    }
    
    // MARK: Navigation

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil);
    }
    
    
    
    // This method lets you configure a view controller before it's presented
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender);
        
        // Configure the desitination view controller only when the save button is pressed
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug);
            return;
        }
        
        let name = nameTextField.text ?? "";
        let photo = photoImageView.image;
        let rating = ratingControl.rating;
        
        // set the meal to be passed to MealTableViewController after the unwind segue
        meal = Meal(name: name, photo: photo, rating: rating);
        
    }

    // MARK: Actions
    
//    @IBAction func setDefaultLabelText(_ sender: UIButton) {
//        mealNameLabel.text = "Default Text, Dude!"
//    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // Ensure that the keyboard is dismissed properly if the user taps the nameTextField
        nameTextField.resignFirstResponder();
        
        // create an image picker controller
        let imagePickerController = UIImagePickerController();

        // Only allow photos to be picked, not taken
        imagePickerController.sourceType = .photoLibrary;
        
        // set the image picker controller's delegate to ViewController
        // making sure ViewController is notified when the user picks an image
        imagePickerController.delegate = self;
        
        // This method asks ViewController to present the view controller defined by imagePickerController.
        // Passing true to animated parameter animates the presentation
        // The completion parameter is set to nil because right now we are not doing anything after this method completes.
        present(imagePickerController, animated: true, completion: nil);
    }
    
    // MARK: Private methods
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty
        let text = nameTextField.text ?? "";
        saveButton.isEnabled = !text.isEmpty;
    }
    
}

