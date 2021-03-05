//
//  BodyMeasurements2ViewController.swift
//  testing
//
//  Created by Austin Leung on 2/26/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore



class GenderViewController: UIViewController {

    // MARK: Buttons / Labels
    
    @IBOutlet weak var radioButtonMale: UIButton!
    
    @IBOutlet weak var radioButtonFemale: UIButton!
    
    @IBOutlet weak var logoLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var selectGenderLabel: UILabel!
    
    @IBOutlet weak var maleLabel: UILabel!
    
    @IBOutlet weak var femaleLabel: UILabel!
    
    
    // define gender state
    // let 0 = male
    // let 1 = female
    var genderState = -1
    var gender = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: UI / Aesthetics
        
        self.view.backgroundColor = .white
        
        logoLabel.textColor = Constants.appColors.orangeRed
        
        makeSolidButton(button: nextButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
        
        selectGenderLabel.text = "Select Biological Gender"
        selectGenderLabel.textColor = Constants.appColors.orangeRed
        maleLabel.textColor = Constants.appColors.softBlack
        femaleLabel.textColor = Constants.appColors.softBlack
        
        backButton.tintColor = Constants.appColors.mustard
        
        
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
        if genderState == -1 {
            return "Please choose one of the options above."
        }
        
        return nil
    }
    
    
    
    // MARK: Button Tap Actions
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        }
        
        else {
            if genderState == 0 {
                gender = "Male"
            }
            
            else if genderState == 1 {
                gender = "Female"
            }
            
            // access current user information
            let db = Firestore.firestore()
            let userID : String = (Auth.auth().currentUser?.uid)!
            let userRef = db.collection("users").document(userID)
            
            // update the height/weight/age of current user (get input)
            userRef.updateData([
                                "gender": gender
            ]) { err in
                if let err = err {
                    print("Error updating gender: \(err)")
                } else {
                    print("Gender successfully updated")
                }
            }
            
            // go to welcome splash screen
            transitionToBM()
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
    
    func transitionToBM() {
        // transition to welcome screen
        let bodyMeasurementsViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.bodyMeasurementsViewController) as? BodyMeasurementsViewController
        
        view.window?.rootViewController = bodyMeasurementsViewController
        view.window?.makeKeyAndVisible()
    }
    
    

    // MARK: Radio Button Actions
    
    @IBAction func radioButtonAction(_ sender: UIButton) {
        if sender.tag == 1 {
            radioButtonMale.isSelected = true
            radioButtonFemale.isSelected = false
            print("Male Selected")
            genderState = 0
        }
        
        else if sender.tag == 2 {
            radioButtonFemale.isSelected = true
            radioButtonMale.isSelected = false
            print("Female Selected")
            genderState = 1
        }
    }
    
    
}
