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
    
    @IBOutlet weak var topBackground: UIView!
    
    @IBOutlet weak var topBar: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var calorieCountLabel: UILabel!
    
    @IBOutlet weak var calorieLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI / AESTHETICS
        // change background color
        self.view.backgroundColor = .white
        topBackground.backgroundColor = Constants.appColors.pearlAqua
        topBar.backgroundColor = Constants.appColors.chineseOrange

        // DATETIME
        dateLabel.textColor = Constants.appColors.softBlack
        calorieLabel.textColor = Constants.appColors.softBlack
        calorieCountLabel.textColor = Constants.appColors.softBlack
        
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
    

    func setCalories(totalCalories: Int, caloriesConsumed: Int) -> Void {
        var calText = ""
        
        calText += String(caloriesConsumed) + " / " + String(totalCalories)
        calorieCountLabel.text = calText
    }
}


