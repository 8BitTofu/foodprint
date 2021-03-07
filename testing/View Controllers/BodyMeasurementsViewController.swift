//
//  BodyMeasurementsViewController.swift
//  testing
//
//  Created by Austin Leung on 2/3/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore




class BodyMeasurementsViewController: UIViewController {
    
    // MARK: Buttons / Labels
    
    @IBOutlet weak var heightTextField: UITextField!
    
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var logoLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // MARK: UI / Aesthetics
        
        self.view.backgroundColor = .white
        
        logoLabel.textColor = Constants.appColors.orangeRed
        
        makeSolidButton(button: nextButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
        
        backButton.tintColor = Constants.appColors.mustard
        
        // testing to see if user is signed in
        if (checkUserIn() == true) {
            print("user in")
        }
        
        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    
    
    // MARK: Setup
    
    func setUpElements() {
        // set error to blank by default
        errorLabel.alpha = 0
    }
    

    func validateFields() -> String? {
        
        // check if any fields are blank
        if
            heightTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                weightTextField.text?.trimmingCharacters(in:.whitespacesAndNewlines) == "" {
            return "Please fill in empty fields"
        }
        
        // trim white space and new lines from text fields
        let cleanedHeight = heightTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedWeight = weightTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedAge = ageTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // convert string to int (unnecessary?)
        let intHeight = Int(cleanedHeight) ?? 0
        let intWeight = Int(cleanedWeight) ?? 0
        let intAge = Int(cleanedAge) ?? 0
        
        // check if height is valid
        if Utilities.isHeightValid(intHeight) == false {
            return "Height given in 'cm' was not within the valid range."
        }
        
        // check if weight is valid
        if Utilities.isWeightValid(intWeight) == false {
            return "Weight given in 'lbs' was not within the valid range."
        }
        
        if Utilities.isAgeValid(intAge) == false {
            return "Age given in 'years' was not within the valid range."
        }
        
        return nil
    }
    
    
    func showError(_ message:String) {
        // show the error (function)
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    
    
    // MARK: Button Actions
    
    @IBAction func nextTapped(_ sender: Any) {
        // (function) when next button is tapped
        let error = validateFields()
        
        if error != nil {
            // ERROR - show error / no action
            showError(error!)
        }
        
        else {
            // NO ERROR - update data fields
            
            // get data from text fields and trim 
            let cleanedHeight = heightTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let cleanedWeight = weightTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let cleanedAge = ageTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // convert string to int
            let intHeight = Int(cleanedHeight) ?? 0
            let intWeight = Int(cleanedWeight) ?? 0
            let intAge = Int(cleanedAge) ?? 0
            
            // access current user information
            let db = Firestore.firestore()
            let userID : String = (Auth.auth().currentUser?.uid)!
            let userRef = db.collection("users").document(userID)
            
            // update the height/weight/age of current user (get input)
            userRef.updateData([
                                "height": intHeight,
                                "weight": intWeight,
                                "age": intAge
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
            
            // go to welcome splash screen
            transitionToWeight()
        }
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        // when clicking back button - delete all previous progress
        // on making a user account
        
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
    
    
    
    // MARK: Transitions
    
    func transitionToBase() {
        // transition to home screen
        let baseViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.baseViewController) as? ViewController
        
        view.window?.rootViewController = baseViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    func transitionToWeight() {
        // transition to welcome screen
        let weightViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.weightViewController) as? WeightViewController
        
        view.window?.rootViewController = weightViewController
        view.window?.makeKeyAndVisible()
    }
    
}

