//
//  LoginViewController.swift
//  testing
//
//  Created by Austin Leung on 2/2/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var loginStack: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // UI / AESTHETICS
        // change background color
        self.view.backgroundColor = Constants.appColors.blond
        
        makeSolidButton(button: loginButton, backgroundColor: Constants.appColors.chineseOrange, textColor: .white)
        
        backButton.tintColor = Constants.appColors.chineseOrange
        
        setUpElements()
    }
    
    
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
                    
                    // transition to welcome screen
                    self.transitionToWelcome()
                }
            }
        }
    }
    
    
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
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.transitionToBase()
    }
    

}
