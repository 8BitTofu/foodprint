//
//  SignUpViewController.swift
//  testing
//
//  Created by Austin Leung on 2/2/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // UI / AESTHETICS
        // change background color
        self.view.backgroundColor = Constants.appColors.blond
        
        nextButton.layer.cornerRadius = 10
        nextButton.backgroundColor = Constants.appColors.chineseOrange
        
        nextButton.setTitleColor(.white, for: .normal)
        backButton.tintColor = Constants.appColors.chineseOrange
        
        
        
        setUpElements()
    }
    
    func setUpElements() {
        // set error to default by default
        errorLabel.alpha = 0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func validateFields() -> String? {
        
        // check fields if filled
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in empty fields."
        }
        
        // check password validity
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // INVALID PASSWORD
            return "Please make sure your password is at least 8 characters, contains a special character, and contains at least one number."
        }
        
        return nil
    }
    
    
    @IBAction func nextTapped(_ sender: Any) {
        // Validate the fields
        let error = validateFields()
        
        if error != nil {
            // ERROR - show error / no action
            showError(error!)
        }
        else {
            // NO ERROR - create user account
            // get textfield data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    self.showError("Error: Could not create a user")
                }
                else {
                    // user created successfully
                    let db = Firestore.firestore()
                    
                    // Add a new document with a generated id
                    let userTableRef = db.collection("users")

                    let userDoc = userTableRef.document(result!.user.uid)

                    // show data fields
                    let dataFields = [
                        "firstname": firstName,
                        "lastname": lastName,
                        "email": email,
                        "uid": result!.user.uid,
                        "weight": 0,
                        "height": 0,
                        "gender": "",
                        "totalCalories": 0,
                        "caloriesConsumed": 0
                    ] as [String : Any]

                    // set the data fields
                    userDoc.setData(dataFields)
                    
                    // console indicator
                    print("SUCCESS: user was signed up")
                    
                    // set user state as a new user
                    setNew()
                    
                    // move to home screen
                    self.transitionToBM()
                }
            }
        }
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.transitionToBase()
    }
    
    
    
    func showError(_ message:String) {
        // show the error (function)
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    
    func transitionToBM() {
        // transition to the body measurements screen
        let BodyMeasurementsViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.bodyMeasurementsViewController) as? BodyMeasurementsViewController
        
        view.window?.rootViewController = BodyMeasurementsViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    func transitionToBase() {
        // transition to home screen
        let baseViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.baseViewController) as? ViewController
        
        view.window?.rootViewController = baseViewController
        view.window?.makeKeyAndVisible()
    }
    
    
}
