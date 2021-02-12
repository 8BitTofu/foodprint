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
    
    @IBOutlet weak var heightTextField: UITextField!
    
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // testing to see if user is signed in
        if Auth.auth().currentUser != nil {
          print("A user is signed in right now.")
        } else {
          print("No user signed in.")
        }
        
        // access current user data
        let user = Auth.auth().currentUser
        let userID : String = (Auth.auth().currentUser?.uid)!
        
        print("User ID: " + userID)
        
        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
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
        var intHeight = Int(cleanedHeight) ?? 0
        var intWeight = Int(cleanedWeight) ?? 0
        var intAge = Int(cleanedAge) ?? 0
        
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
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    
    @IBAction func nextTapped(_ sender: Any) {
        
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        }
        
        else {
            // get data from text fields and trim 
            let cleanedHeight = heightTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let cleanedWeight = weightTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let cleanedAge = ageTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // var intHeight = Int(cleanedHeight) ?? 0
            // var intWeight = Int(cleanedWeight) ?? 0
            // var intAge = Int(cleanedAge) ?? 0
            
            let db = Firestore.firestore()
            let userID : String = (Auth.auth().currentUser?.uid)!
            
            let userRef = db.collection("users").document(userID)
            
            userRef.updateData([
                                "height": cleanedHeight,
                                "weight": cleanedWeight,
                                "age": cleanedAge
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
        }
    }
}

