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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: UI / Aesthetics
        
        makeSolidButton(button: addMealButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
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
        
        if lastDate != dateString {
            lastDate = dateString
            sameDay = false
        }
        else {
            print("lastDate: " + lastDate)
            print("today: " + dateString)
            sameDay = true
        }
        
        
        
        
        
        // Personalizing Calorie Count
        var totalCalories = 0
        var caloriesConsumed = 0
        
        let db = Firestore.firestore()
        let userID : String = getCurrentUserID()
        let userRef = db.collection("users").document(userID)
        
        userRef.getDocument(source: .cache) { (document, error) in
            if let document = document {
                let height = document.get("height") as! Int
                let weight = document.get("weight") as! Int
                let age = document.get("age") as! Int
                let exerciseAmt = document.get("exerciseAmt") as! String
                let gender = document.get("gender") as! String
                let caloriesConsumed = document.get("caloriesConsumed") as! Int
                
                if (gender == "Male") {
                    totalCalories = Int(calcMaleCalories(weightLB: weight, heightCM: height, ageYR: age, exerciseAmt: exerciseAmt))
                }
                
                if (gender == "Female") {
                    totalCalories = Int(calcFemaleCalories(weightLB: weight, heightCM: height, ageYR: age, exerciseAmt: exerciseAmt))
                }
                
                
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
                
                
                // if new day, reset calories consumed
                if sameDay == false {
                    userRef.updateData([
                        "caloriesConsumed": 0
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
    
    
    
    
    // MARK: Set Calories
    
    func setCalories(totalCalories: Int, caloriesConsumed: Int) -> Void {
        var calText = ""
        
        calText += String(caloriesConsumed) + " / " + String(totalCalories)
        calorieCountLabel.text = calText
    }
    
    
    func transitionToAddMeal() {
        // transition to account screen
        let addMealViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.addMealViewController) as? AddMealViewController
        
        view.window?.rootViewController = addMealViewController
        view.window?.makeKeyAndVisible()
    }
}
