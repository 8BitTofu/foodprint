//
//  UpdateBMViewController.swift
//  testing
//
//  Created by Austin Leung on 3/5/21.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class UpdateBMViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var logoLabel: UILabel!
    
    @IBOutlet weak var updateLabel: UILabel!
    
    @IBOutlet weak var updateTextField: UITextField!
    
    @IBOutlet weak var updateButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // MARK: UI / Aesthetics
        backButton.tintColor = Constants.appColors.mustard
        logoLabel.textColor = Constants.appColors.orangeRed
        updateLabel.textColor = Constants.appColors.orangeRed
        
        makeSolidButton(button: updateButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
        updateButton.setTitle("Update", for: .normal)
        
        setUpElements()
    }
    
    
    // MARK: Setup
    
    func setUpElements() {
        // set error to blank by default
        errorLabel.alpha = 0
        
        if (updateBM == "weight") {
            // weight
            updateLabel.text = "Enter New Weight (lbs)"
        }
        
        if (updateBM == "height") {
            // height
            updateLabel.text = "Enter New Height (cm)"
        }
        
        if (updateBM == "age") {
            // age
            updateLabel.text = "Enter New Age"
        }
    }
    
    
    func showError(_ message:String) {
        // show the error (function)
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    
    func validateFields() -> String? {
        if updateTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please enter a value."
        }
        
        let cleanedInput = updateTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let intInput = Int(cleanedInput) ?? 0
        
        if (updateBM == "weight") {
            // weight
            if (Utilities.isWeightValid(intInput) == false) {
                return "Weight given in 'lbs' was not within the valid range."
            }
        }
        
        if (updateBM == "height") {
            // height
            if (Utilities.isHeightValid(intInput) == false) {
                return "Height given in 'cm' was not within the valid range."
            }
        }
        
        if (updateBM == "age") {
            // age
            if (Utilities.isAgeValid(intInput) == false) {
                return "Age given in 'years' was not within the valid range."
            }
        }
        
        return nil
    }
    
    
    func successAdd() {
        updateButton.setTitle("Success!", for: .normal)
        makeSolidButton(button: updateButton, backgroundColor: .green, textColor: .white)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let accountViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.accountViewController) as? AccountViewController
            
            self.view.window?.rootViewController = accountViewController
            self.view.window?.makeKeyAndVisible()
        }
    }

    
    
    // MARK: Button Actions
    
    @IBAction func backButtonTapped(_ sender: Any) {
        transitionToAccount()
    }
    
    @IBAction func updateTapped(_ sender: Any) {
        // (function) when next button is tapped
        let error = validateFields()
        
        if error != nil {
            // ERROR - show error / no action
            showError(error!)
        }
        
        else {
            let cleanedInput = updateTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let intInput = Int(cleanedInput) ?? 0

            // access current user information
            let db = Firestore.firestore()
            let userID : String = (Auth.auth().currentUser?.uid)!
            let userRef = db.collection("users").document(userID)
            
            
            // update the height/weight/age of current user (get input)
            userRef.updateData([
                                updateBM: intInput
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
            
            
            // reset updateBM
            updateBM = ""
            refreshMeals = true
            
            // transition back
            successAdd()
        }
    }
    
    
    // MARK: Transitions
    
    func transitionToAccount() {
        // transition to home screen
        let accountViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.accountViewController) as? AccountViewController
        
        view.window?.rootViewController = accountViewController
        view.window?.makeKeyAndVisible()
    }
}
