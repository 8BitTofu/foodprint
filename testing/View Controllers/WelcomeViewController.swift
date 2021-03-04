//
//  WelcomeViewController.swift
//  testing
//
//  Created by Austin Leung on 2/17/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var logoLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidAppear(true)
        
        // change background color
        self.view.backgroundColor = .white
        
        logoLabel.textColor = Constants.appColors.orangeRed
        
        
        // MARK: Access User Data
        
        // accessing the first name and last name of current user
        let db = Firestore.firestore()
        let userID : String = getCurrentUserID()
        let userRef = db.collection("users").document(userID)
        
        var firstName : String = ""
        var lastName : String = ""
        var height : Int = -1
        var weight : Int = -1
        var age : Int = -1
        var exerciseAmt : String = ""
        var gender : String = ""
        var totalCalories = 0.00
        
        
        // set the welcome text to personalized name
        userRef.getDocument(source: .cache) { (document, error) in
            if let document = document {
                firstName = document.get("firstname") as! String
                lastName = document.get("lastname") as! String
                height = document.get("height") as! Int
                weight = document.get("weight") as! Int
                age = document.get("age") as! Int
                exerciseAmt = document.get("exerciseAmt") as! String
                gender = document.get("gender") as! String
                
                
                // if user is new, calculate the calorie total
                
                if (isReturning() == false) {
                    if (gender == "Male") {
                        totalCalories = calcMaleCalories(weightLB: weight, heightCM: height, ageYR: age, exerciseAmt: exerciseAmt)
                    }
                    
                    if (gender == "Female") {
                        totalCalories = calcFemaleCalories(weightLB: weight, heightCM: height, ageYR: age, exerciseAmt: exerciseAmt)
                    }
                    
                    
                    // update totalCalories data field in user
                    userRef.updateData([
                                        "totalCalories": Int(totalCalories)
                    ]) { err in
                        if let err = err {
                            print("Error updating total calories: \(err)")
                        } else {
                            print("Total calories successfully updated")
                        }
                    }
                }
                
                
                self.setWelcomeName(firstName: firstName, lastName: lastName)
            } else {
                print("Cannot access current user's firstname and lastname")
            }
        }
        

        
        // MARK: Delay Time
        
        // after some time change from splash screen to home screen
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let tabbedViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabbedViewController) as? TabbedViewController
            
            self.view.window?.rootViewController = tabbedViewController
            self.view.window?.makeKeyAndVisible()
        }

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: Setup

    func setWelcomeName(firstName:String, lastName:String) -> Void {
        var welcomeText = "Welcome "
        // print("TEXT: " + String(welcomeState))
        
        if (isReturning() == true) {
            print("in returning")
            welcomeText += "back, "
        }
        
        welcomeText += firstName + " " + lastName + "!"
        welcomeLabel.text = welcomeText
    }
    

}
