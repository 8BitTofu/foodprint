//
//  AddMealViewController.swift
//  testing
//
//  Created by Austin Leung on 3/5/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class AddMealViewController: UIViewController {
    
    // MARK: Question Labels / Button
    
    @IBOutlet weak var whatFoodLabel: UILabel!
    
    @IBOutlet weak var howCaloriesLabel: UILabel!
    
    @IBOutlet weak var addMealButton: UIButton!
    
    @IBOutlet weak var logoLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    // MARK: Radio Buttons / Labels
    
    @IBOutlet weak var breakfastRadioButton: UIButton!
    
    @IBOutlet weak var lunchRadioButton: UIButton!
    
    @IBOutlet weak var dinnerRadioButton: UIButton!
    
    @IBOutlet weak var otherRadioButton: UIButton!
    
    @IBOutlet weak var breakfastLabel: UILabel!
    
    @IBOutlet weak var lunchLabel: UILabel!
    
    @IBOutlet weak var dinnerLabel: UILabel!
    
    @IBOutlet weak var otherLabel: UILabel!
    
    
    // MARK: Calories Text Field
    
    @IBOutlet weak var caloriesTextField: UITextField!
    
    
    // MARK: State
    var mealState = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
        
        // MARK: UI / Aesthetics
        
        addMealButton.setTitle("Add Meal", for: .normal)
        makeSolidButton(button: addMealButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
        
        logoLabel.textColor = Constants.appColors.orangeRed
        backButton.tintColor = Constants.appColors.mustard
        whatFoodLabel.textColor = Constants.appColors.orangeRed
        howCaloriesLabel.textColor = Constants.appColors.orangeRed
        
        makeSolidButton(button: addMealButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
        
        
    }
    
    
    // MARK: Setup
    
    func setUpElements() {
        // set error to blank by default
        errorLabel.alpha = 0
    }
    
    
    func showError(_ message:String) {
        // show the error (function)
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func validateFields() -> String? {
        if mealState == -1 {
            return "Please choose a meal option above."
        }
        else if caloriesTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please enter calorie amount."
        }
        
        return nil
    }
    
    
    func successAdd() {
        addMealButton.setTitle("Success!", for: .normal)
        makeSolidButton(button: addMealButton, backgroundColor: .green, textColor: .white)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let tabbedViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabbedViewController) as? TabbedViewController
            
            self.view.window?.rootViewController = tabbedViewController
            self.view.window?.makeKeyAndVisible()
        }
    }

    
    // MARK: Button Actions
    
    @IBAction func backButtonTapped(_ sender: Any) {
        transitionToHome()
    }
    
    @IBAction func radioButtonTapped(_ sender: UIButton) {
        if sender.tag == 1 {
            breakfastRadioButton.isSelected = true
            lunchRadioButton.isSelected = false
            dinnerRadioButton.isSelected = false
            otherRadioButton.isSelected = false
            print("Breakfast Selected")
            mealState = 1
        }
        
        else if sender.tag == 2 {
            breakfastRadioButton.isSelected = false
            lunchRadioButton.isSelected = true
            dinnerRadioButton.isSelected = false
            otherRadioButton.isSelected = false
            print("Lunch Selected")
            mealState = 2
        }
        
        else if sender.tag == 3 {
            breakfastRadioButton.isSelected = false
            lunchRadioButton.isSelected = false
            dinnerRadioButton.isSelected = true
            otherRadioButton.isSelected = false
            print("Dinner Selected")
            mealState = 3
        }
        
        else if sender.tag == 4 {
            breakfastRadioButton.isSelected = false
            lunchRadioButton.isSelected = false
            dinnerRadioButton.isSelected = false
            otherRadioButton.isSelected = true
            print("Other Selected")
            mealState = 4
        }
    }
    
    
    @IBAction func addMealTapped(_ sender: Any) {
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        }
        
        else {
            let cleanedCalories = caloriesTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            var currentCaloriesConsumed = -1
            
            
            // update data
            let db = Firestore.firestore()
            let userID : String = (Auth.auth().currentUser?.uid)!
            let userRef = db.collection("users").document(userID)
            
            
            userRef.getDocument(source: .cache) { (document, error) in
                if let document = document {
                    currentCaloriesConsumed = document.get("caloriesConsumed") as! Int
                    let currentMealNum = document.get("mealNum") as! Int
                    
                    // update the height/weight/age of current user (get input)
                    userRef.updateData([
                        "caloriesConsumed": currentCaloriesConsumed + Int(cleanedCalories)!,
                        "mealNum": currentMealNum + 1
                    ]) { err in
                        if let err = err {
                            print("Error adding new meal: \(err)")
                        } else {
                            print("New meal successfully added")
                        }
                    }
                    
                    
                    // update which meal has been eaten
                    
                    if (self.mealState == 1) {
                        userRef.updateData([
                            "hadBreakfast": true
                        ]) { err in
                            if let err = err {
                                print("Error updating hadBreakfast: \(err)")
                            } else {
                                print("hadBreakfast successfully updated")
                            }
                        }
                    }
                    
                    if (self.mealState == 2) {
                        userRef.updateData([
                            "hadLunch": true
                        ]) { err in
                            if let err = err {
                                print("Error updating hadLunch: \(err)")
                            } else {
                                print("hadLunch successfully updated")
                            }
                        }
                    }
                    
                    if (self.mealState == 3) {
                        userRef.updateData([
                            "hadDinner": true
                        ]) { err in
                            if let err = err {
                                print("Error updating hadDinner: \(err)")
                            } else {
                                print("hadDinner successfully updated")
                            }
                        }
                    }
                    
                    
                } else {
                    print("Cannot access current user's calorie consumed")
                }
            }
            

            refreshMeals = true
            successAdd()
        }
    }
    
    
    // MARK: Transitions
    
    func transitionToHome() {
        // transition to home screen
        let tabbedViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabbedViewController) as? TabbedViewController
        
        view.window?.rootViewController = tabbedViewController
        view.window?.makeKeyAndVisible()
    }

}
