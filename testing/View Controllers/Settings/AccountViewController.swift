//
//  AccountViewController.swift
//  testing
//
//  Created by Austin Leung on 3/4/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore


class AccountViewController: UIViewController {

    
    // MARK: Other Buttons / Labels
    
    @IBOutlet var backButton: UIButton!
    
    @IBOutlet var logoLabel: UILabel!
    
    @IBOutlet var deleteAccountButton: UIButton!
    
    
    
    // MARK: Description Labels
    
    @IBOutlet var weightDescLabel: UILabel!
    
    @IBOutlet var heightDescLabel: UILabel!
    
    @IBOutlet var ageDescLabel: UILabel!
    
    @IBOutlet var weightOptionDescLabel: UILabel!
    
    
    
    // MARK: Dynamic Labels
    
    @IBOutlet var dWeightLabel: UILabel!
    
    @IBOutlet var dHeightLabel: UILabel!
    
    @IBOutlet var dAgeLabel: UILabel!
    
    @IBOutlet var dWeightOptionLabel: UILabel!
    
    
    // MARK: Update Buttons
    
    @IBOutlet var updateWeightButton: UIButton!
    
    @IBOutlet var updateHeightButton: UIButton!
    
    @IBOutlet var updateAgeButton: UIButton!
    
    @IBOutlet var updateWeightOptionButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // MARK: UI / Aesthetics
        
        backButton.tintColor = Constants.appColors.mustard
        logoLabel.textColor = Constants.appColors.orangeRed
        weightDescLabel.textColor = Constants.appColors.orangeRed
        heightDescLabel.textColor = Constants.appColors.orangeRed
        ageDescLabel.textColor = Constants.appColors.orangeRed
        weightOptionDescLabel.textColor = Constants.appColors.orangeRed
        
        makeSolidButton(button: updateWeightButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
        makeSolidButton(button: updateHeightButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
        makeSolidButton(button: updateAgeButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
        makeSolidButton(button: updateWeightOptionButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
        
        makeGhostButton(button: deleteAccountButton, color: Constants.appColors.orangeRed)
        
        
        // MARK: Configure Dynamic Account Labels
        
        
        
        var weight = -1
        var height = -1
        var age = -1
        var weightOption = ""
        
        let db = Firestore.firestore()
        let userID : String = getCurrentUserID()
        let userRef = db.collection("users").document(userID)
        
        userRef.getDocument(source: .cache) { [self] (document, error) in
            if let document = document {
                weight = document.get("weight") as! Int
                height = document.get("height") as! Int
                age = document.get("age") as! Int
                weightOption = document.get("weightChange") as! String
                
                dWeightLabel.text = String(weight)
                dHeightLabel.text = String(height)
                dAgeLabel.text = String(age)
                dWeightOptionLabel.text = weightOption
                
            } else {
                print("Cannot access current user's calorie count / consumed")
            }
        }
        
        
    }
    
    
    // MARK: Update Button Tapped
    
    @IBAction func updateWeightButtonTapped(_ sender: Any) {
        updating = true
        updateBM = "weight"
        transitionToUpdateBM()
    }
    
    @IBAction func updateHeightButtonTapped(_ sender: Any) {
        updating = true
        updateBM = "height"
        transitionToUpdateBM()
    }
    
    @IBAction func updateAgeButtonTapped(_ sender: Any) {
        updating = true
        updateBM = "age"
        transitionToUpdateBM()
    }
    
    @IBAction func updateWeightOptionButtonTapped(_ sender: Any) {
        updating = true
        transitionToWeight()
    }
    
    @IBAction func updateExerciseButtonTapped(_ sender: Any) {
        updating = true
    }
    
    
    
    // MARK: Other Button Tapped
    
    @IBAction func backButtonTapped(_ sender: Any) {
        transitionToHome()
        
    }
    
    @IBAction func deleteAccountButtonTapped(_ sender: Any) {
        transitionToDeleteAccount()
    }
    
    
    // MARK: Transitions
    
    func transitionToHome() {
        // transition to home screen
        let tabbedViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabbedViewController) as? TabbedViewController
        
        view.window?.rootViewController = tabbedViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToDeleteAccount() {
        // transition to home screen
        let deleteAccountViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.deleteAccountViewController) as? DeleteAccountViewController
        
        view.window?.rootViewController = deleteAccountViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToWeight() {
        // transition to welcome screen
        let weightViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.weightViewController) as? WeightViewController
        
        view.window?.rootViewController = weightViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToUpdateBM() {
        // transition to welcome screen
        let updateBMViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.updateBMViewController) as? UpdateBMViewController
        
        view.window?.rootViewController = updateBMViewController
        view.window?.makeKeyAndVisible()
    }
    
}
