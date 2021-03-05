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
        
        let formatter = DateFormatter()
        //2016-12-08 03:37:22 +0000
        formatter.dateFormat = "MM.dd.yyyy"
        let now = Date()
        let dateString = formatter.string(from:now)
        NSLog("%@", dateString)
        
        dateLabel.text = dateString
        
        
        
        // Personalizing Calorie Count
        var totalCalories = 0
        var caloriesConsumed = 0
        
        let db = Firestore.firestore()
        let userID : String = getCurrentUserID()
        let userRef = db.collection("users").document(userID)
        
        userRef.getDocument(source: .cache) { (document, error) in
            if let document = document {
                totalCalories = document.get("totalCalories") as! Int
                caloriesConsumed = document.get("caloriesConsumed") as! Int
                
                self.setCalories(totalCalories: totalCalories, caloriesConsumed: caloriesConsumed)
            } else {
                print("Cannot access current user's calorie count / consumed")
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


