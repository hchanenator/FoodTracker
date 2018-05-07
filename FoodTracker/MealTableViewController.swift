//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Herb Chan on 2018-05-02.
//

import UIKit

class MealTableViewController: UITableViewController {
    
    // MARK: Properties
    var meals = [Meal]();

    override func viewDidLoad() {
        super.viewDidLoad()

        // load sample data
        loadSampleMeals();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Return the number of meals in the Meals array
        return meals.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // dequeuResuableCell will try to reuse a cell that is off the scene as the user scrolls,
        // rather than continually trying to create new cells.  Only when there are no cells
        // available for reuse will it create a new one.  We also need to tell it what type of cell
        // to create if it needs to
        
        // Table view cells are reused and should be dequeued using a cell identifier
        let cellIdentifier = "MealTableViewCell";
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell");
        }
        
        // Fetches the appropriate meal for the data source layout
        let meal = meals[indexPath.row];

        // use the meal object to configure your cell
        cell.nameLabel.text = meal.name;
        cell.photoImageView.image = meal.photo;
        cell.ratingControl.rating = meal.rating;

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: Actions
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
            // add a new meal
            let newIndexPath = IndexPath(row: meals.count, section: 0);
            meals.append(meal);
            tableView.insertRows(at: [newIndexPath], with: .automatic);
        }
    }
    
    // MARK: Private Methods
    private func loadSampleMeals() {
        // load the 3 sample images
        let photo1 = UIImage(named: "meal1");
        let photo2 = UIImage(named: "meal2");
        let photo3 = UIImage(named: "meal3");
        
        // create the 3 meal objects
        guard let meal1 = Meal(name: "Some Salad", photo: photo1, rating: 4) else {
            fatalError("Unable to instantiate meal1");
        }
        
        guard let meal2 = Meal(name: "Chicken and Potatos", photo: photo2, rating: 5) else {
            fatalError("Unable to instantiate meal2");
        }
        
        guard let meal3 = Meal(name: "Spaghetti with Meatballs", photo: photo3, rating: 3) else {
            fatalError("Unable to instantiate meal3");
        }
        
        meals += [meal1, meal2, meal3];
    }

}
