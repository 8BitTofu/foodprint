//
//  ExerciseViewController.swift
//  testing
//
//  Created by Austin Leung on 2/27/21.
//

//  This file has been changed from exercise amount to WEIGHT CHANGE


import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class WeightViewController: UIViewController{

    // MARK: Buttons / Labels
    
    @IBOutlet weak var logoLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var radioButtonLow: UIButton!
    
    @IBOutlet weak var radioButtonMedium: UIButton!
    
    @IBOutlet weak var radioButtonHigh: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var selectLabel: UILabel!
    
    @IBOutlet weak var optionLowLabel: UILabel!
    
    @IBOutlet weak var optionMediumLabel: UILabel!
    
    @IBOutlet weak var optionHighLabel: UILabel!
    
    
    // define exercise state
    // 1: low, 2: medium, 3: high
    var weightState = -1
    var weightChange = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: UI / Aesthetics
        
        self.view.backgroundColor = .white
        
        logoLabel.textColor = Constants.appColors.orangeRed
        
        makeSolidButton(button: nextButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
        
        backButton.tintColor = Constants.appColors.mustard
        
        selectLabel.textColor = Constants.appColors.orangeRed
        optionLowLabel.textColor = Constants.appColors.softBlack
        optionMediumLabel.textColor = Constants.appColors.softBlack
        optionHighLabel.textColor = Constants.appColors.softBlack
        
        
        // MARK: Updating Check
        
        if (updating == true) {
            nextButton.setTitle("Update", for: .normal)
        }
        
        else {
            nextButton.setTitle("Next", for: .normal)
        }
        
        
        setUpElements()
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
        if weightState == -1 {
            return "Please choose one of the options above."
        }
        
        return nil
    }
    
    
    
    // MARK: Button Actions
    
    @IBAction func backButtonTapped(_ sender: Any) {
        // when clicking back button - delete all previous progress
        // on making a user account
        
        if (updating == true) {
            transitionToAccount()
        }
        
        else {
            // get current user data
            let db = Firestore.firestore()
            let userID : String = (Auth.auth().currentUser?.uid)!
            
            // delete user document from users collection on Firebase
            db.collection("users").document(userID).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
            
            // delete user account from authentification side
            Auth.auth().currentUser?.delete(completion: { err in
                if let err = err {
                    print("Error removing user: \(err)")
                } else {
                    print("User successfully removed!")
                }
            })
            
            self.transitionToBase()
        }
    }
    
    
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        }
        
        else {
            if weightState == 1 {
                weightChange = "Lose"
            }
            
            else if weightState == 2 {
                weightChange = "Maintain"
            }
            
            else if weightState == 3 {
                weightChange = "Gain"
            }
            
            
            // access current user information
            let db = Firestore.firestore()
            let userID : String = (Auth.auth().currentUser?.uid)!
            let userRef = db.collection("users").document(userID)
            
            // update the height/weight/age of current user (get input)
            userRef.updateData([
                                "weightChange": weightChange
            ]) { err in
                if let err = err {
                    print("Error updating weight change type: \(err)")
                } else {
                    print("Weight change type successfully updated")
                }
            }
            
            // updating check
            if (updating == true) {
                nextButton.setTitle("Success!", for: .normal)
                makeSolidButton(button: nextButton, backgroundColor: .green, textColor: .white)
                
                updating = false
                refreshMeals = true
                transitionToAccount()
            }
            
            // go to welcome splash screen
            else {
                transitionToPreferences()
            }
        }
    }
    
    
    
    // MARK: Transitions
    
    func transitionToBase() {
        // transition to home screen
        let baseViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.baseViewController) as? ViewController
        
        view.window?.rootViewController = baseViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    func transitionToPreferences() {
        // transition to welcome screen
        let preferencesViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.preferencesViewController) as? PreferencesViewController
        
        view.window?.rootViewController = preferencesViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToAccount() {
        // transition to home screen
        let accountViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.accountViewController) as? AccountViewController
        
        view.window?.rootViewController = accountViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    
    // MARK: Radio Button Actions
    
    @IBAction func radioButtonAction(_ sender: UIButton) {
        if sender.tag == 1 {
            radioButtonLow.isSelected = true
            radioButtonMedium.isSelected = false
            radioButtonHigh.isSelected = false
            print("Lose Weight Selected")
            weightState = 1
        }
        
        else if sender.tag == 2 {
            radioButtonLow.isSelected = false
            radioButtonMedium.isSelected = true
            radioButtonHigh.isSelected = false
            print("Maintain Weight Selected")
            weightState = 2
        }
        
        else if sender.tag == 3 {
            radioButtonLow.isSelected = false
            radioButtonMedium.isSelected = false
            radioButtonHigh.isSelected = true
            print("Gain Weight Selected")
            weightState = 3
        }
    }
    
}
