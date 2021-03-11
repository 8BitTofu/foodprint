//
//  HomeViewController.swift
//  testing
//
//  Created by Austin Leung on 2/19/21.
//  Date/Time code provided by Stack Overflow user LorenzOliveto
//  https://stackoverflow.com/questions/35700281/date-format-in-swift
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeViewController: UIViewController {
    
    // MARK: Buttons / Labels
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var calorieCountLabel: UILabel!
    
    @IBOutlet weak var calorieLabel: UILabel!
    
    @IBOutlet weak var addMealButton: UIButton!
    
    
    
    // MARK: Recommendation Buttons / Labels
    
    @IBOutlet weak var rec1Image: UIImageView!
    
    @IBOutlet weak var rec2Image: UIImageView!
    
    @IBOutlet weak var rec3Image: UIImageView!
    
    @IBOutlet weak var rec1NameLabel: UILabel!
    
    @IBOutlet weak var rec2NameLabel: UILabel!
    
    @IBOutlet weak var rec3NameLabel: UILabel!
    
    @IBOutlet weak var rec1CalorieLabel: UILabel!
    
    @IBOutlet weak var rec2CalorieLabel: UILabel!
    
    @IBOutlet weak var rec3CalorieLabel: UILabel!
    
    @IBOutlet weak var rec1InfoButton: UIButton!
    
    @IBOutlet weak var rec2InfoButton: UIButton!
    
    @IBOutlet weak var rec3InfoButton: UIButton!

    @IBOutlet weak var rec1Stack: UIStackView!
    
    @IBOutlet weak var rec2Stack: UIStackView!
    
    @IBOutlet weak var rec3Stack: UIStackView!
    
    @IBOutlet weak var refreshButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // MARK: UI / Aesthetics
        
        makeSolidButton(button: addMealButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
       // makeSolidButton(button: addStepometerButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
        makeSolidButton(button: rec1InfoButton, backgroundColor: Constants.appColors.mustard, textColor: .white)
        makeSolidButton(button: rec2InfoButton, backgroundColor: Constants.appColors.mustard, textColor: .white)
        makeSolidButton(button: rec3InfoButton, backgroundColor: Constants.appColors.mustard, textColor: .white)
        makeGhostButton(button: refreshButton, color: Constants.appColors.mustard)
        
        
        self.view.backgroundColor = .white
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "fp_homepage")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)

        
        
        // DATETIME
        dateLabel.textColor = Constants.appColors.orangeRed
        calorieLabel.textColor = Constants.appColors.softGrey
        calorieCountLabel.textColor = Constants.appColors.orangeRed
        
        let dateString = Utilities.getDate()
        
        dateLabel.text = dateString
        
        
        
        // MARK: Checking Same Day
        
        let db = Firestore.firestore()
        let userID : String = getCurrentUserID()
        let userRef = db.collection("users").document(userID)
        
        print(userID)
        
        userRef.getDocument(source: .cache) { (document, error) in
            if let document = document {
                let lastLogin = document.get("lastLogin") as! String
                
                if lastLogin != dateString {
                    // print("lastDate: " + lastLogin)
                    // print("today: " + dateString)
                    
                    userRef.updateData([
                                        "lastLogin": dateString
                    ]) { err in
                        if let err = err {
                            print("Error updating last login date: \(err)")
                        } else {
                            print("Last login date successfully updated")
                        }
                    }
                    
                    sameDay = false
                }
                else {
                    sameDay = true
                }
            } else {
                print("Cannot access current user for last login datetime")
            }
        }
        
        switch (sameDay) {
        case true:
            print("SAME DAY")
        case false:
            print("NEW/DIFFERENT DAY")
        }
        
        

        
        
        
        
        
        // Personalizing Calorie Count
        var totalCalories = 0
        
        userRef.getDocument(source: .cache) { (document, error) in
            if let document = document {
                let height = document.get("height") as! Int
                let weight = document.get("weight") as! Int
                let age = document.get("age") as! Int
                let exerciseAmt = document.get("exerciseAmt") as! String
                let gender = document.get("gender") as! String
                let caloriesConsumed = document.get("caloriesConsumed") as! Int
                let hadBreakfast = document.get("hadBreakfast") as! Bool
                let hadLunch = document.get("hadLunch") as! Bool
                let hadDinner = document.get("hadDinner") as! Bool
                
                var breakfastCals: Double = 0.0
                var lunchCals: Double = 0.0
                var dinnerCals: Double = 0.0
                
                
                
                if (gender == "Male") {
                    totalCalories = Int(calcMaleCalories(weightLB: weight, heightCM: height, ageYR: age, exerciseAmt: exerciseAmt))
                }
                
                if (gender == "Female") {
                    totalCalories = Int(calcFemaleCalories(weightLB: weight, heightCM: height, ageYR: age, exerciseAmt: exerciseAmt))
                }
                
                let caloriesLeftover = totalCalories - caloriesConsumed
                
                
                // update totalCalories data field in user
                userRef.updateData([
                                    "totalCalories": totalCalories
                ]) { err in
                    if let err = err {
                        print("Error updating total calories: \(err)")
                    } else {
                        print("Total calories successfully updated")
                    }
                }
                
                
                // divide up the meals from total calories
                if (hadBreakfast == false) {
                    breakfastCals = Double(caloriesLeftover) * 0.3
                    lunchCals = Double(caloriesLeftover) * 0.4
                    dinnerCals = Double(caloriesLeftover) * 0.3
                }
                
                else if (hadLunch == false) {
                    breakfastCals = 0
                    lunchCals = Double(caloriesLeftover) * (4/7)
                    dinnerCals = Double(caloriesLeftover) * (3/7)
                }
                
                else if (hadDinner == false) {
                    breakfastCals = 0
                    lunchCals = 0
                    dinnerCals = Double(caloriesLeftover)
                }
                
                userRef.updateData([
                    "breakfastCals": Int(breakfastCals),
                    "lunchCals": Int(lunchCals),
                    "dinnerCals": Int(dinnerCals)
                ]) { err in
                    if err != nil {
                        print("Error updating individual breakfast, lunch, dinner calories")
                    } else {
                        print("Success: individual breakfast, lunch, dinner calories updated")
                    }
                }
                
                
                
                
                
                // if new day, reset calories consumed
                if sameDay == false {
                    userRef.updateData([
                        "caloriesConsumed": 0,
                        "hadBreakfast": false,
                        "hadLunch": false,
                        "hadDinner": false
                    ]) { err in
                        if err != nil {
                            print("Error resetting calories consumed due to new day")
                        } else {
                            print("Calories consumed reset due to new day")
                        }
                    }
                }
                
                self.setCalories(totalCalories: totalCalories, caloriesConsumed: caloriesConsumed)
            }
        }
    }
    
    
    
    
    // MARK: Button Actions
    
    @IBAction func addMealTapped(_ sender: Any) {
        transitionToAddMeal()
    }
    
    @IBAction func infoTapped(_ sender: Any) {
        transitionToRecipeView()
    }
    
    
    
    
    
    
    
    
    
    // MARK: Set Calories
    
    func setCalories(totalCalories: Int, caloriesConsumed: Int) -> Void {
        var calText = ""
        
        calText += String(caloriesConsumed) + " / " + String(totalCalories)
        calorieCountLabel.text = calText
    }
    
    
    // MARK: Transitions
    
    func transitionToAddMeal() {
        // transition to account screen
        let addMealViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.addMealViewController) as? AddMealViewController
        
        view.window?.rootViewController = addMealViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToRecipeView() {
        // transition to account screen
        let recipeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.recipeViewController) as? RecipeViewController
        
        view.window?.rootViewController = recipeViewController
        view.window?.makeKeyAndVisible()
    }
    
    
}
