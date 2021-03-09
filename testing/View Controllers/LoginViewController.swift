//
//  LoginViewController.swift
//  testing
//
//  Created by Austin Leung on 2/2/21.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class LoginViewController: UIViewController {
    
    // MARK: Buttons / Labels
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var loginStack: UIStackView!
    
    @IBOutlet weak var logoLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: UI / Aesthetics
        
        self.view.backgroundColor = .white
        
        logoLabel.textColor = Constants.appColors.orangeRed
        
        makeSolidButton(button: loginButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
        
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
        
        // check fields if filled
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in empty fields."
        }
        
        return nil
    }
    
    
    
    // MARK: Button Actions
    
    @IBAction func loginTapped(_ sender: Any) {
        
        // check if fields are empty
        let error = validateFields()
        
        if error != nil {
            // ERROR - show error / no action
            showError(error!)
        }
        else {
            // cleaned versions
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                
                if error != nil {
                    self.errorLabel.text = error!.localizedDescription
                    self.errorLabel.alpha = 1
                }
                else {
                    // set user state as returning
                    setReturning()
                    
                    let db = Firestore.firestore()
                    let userID : String = (Auth.auth().currentUser?.uid)!
                    let userRef = db.collection("users").document(userID)
                    
                    // update the height/weight/age of current user (get input)
                    userRef.updateData([
                        "lastLogin": Utilities.getDate()
                    ]) { err in
                        if let err = err {
                            print("Error updating last login time: \(err)")
                        } else {
                            print("Last login successfully updated")
                        }
                    }
                    
                    
                    // transition to welcome screen
                    self.transitionToWelcome()
                }
            }
        }
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.transitionToBase()
    }
    
    
    
    // MARK: Transitions
    
    func transitionToWelcome() {
        // transition to welcome screen
        let welcomeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.welcomeViewController) as? WelcomeViewController
        
        view.window?.rootViewController = welcomeViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    func transitionToBase() {
        // transition to home screen
        let baseViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.baseViewController) as? ViewController
        
        view.window?.rootViewController = baseViewController
        view.window?.makeKeyAndVisible()
    }
}
