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
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
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
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        // Validate the fields
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        }
        else {
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
                    
                    // Add a new document with a generated id.
                    let userTableRef = db.collection("users")

                    let userDoc = userTableRef.document(result!.user.uid)
                    let dataFields = [
                        "firstname": firstName,
                        "lastname": lastName,
                        "email": email,
                        "uid": result!.user.uid,
                        // "docid": userDoc.documentID,
                        "weight": 0,
                        "height": 0,
                        "gender": ""
                    ] as [String : Any]

                    userDoc.setData(dataFields)
                    
                    /*
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "email":email, "uid":result!.user.uid, "weight":0, "height":0, "gender":""]) { (error) in
                        if error != nil {
                            self.showError("Error: user data couldn't be saved.")
                        }
                    }
 */
                    
                    print("SUCCESS: user was signed up")
                    
                    // move to home screen
                    self.transitionToBM()
                }
            }
        }
    }
    
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    
    func transitionToBM() {
        let BodyMeasurementsViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.BodyMeasurementsViewController) as? BodyMeasurementsViewController
        
        view.window?.rootViewController = BodyMeasurementsViewController
        view.window?.makeKeyAndVisible()
    }
}
