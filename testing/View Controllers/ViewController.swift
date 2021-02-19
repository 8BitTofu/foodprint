//
//  ViewController.swift
//  testing
//
//  Created by Austin Leung on 2/1/21.
//

import UIKit
import Foundation
import HealthKit

class ViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        // UI / AESTHETICS
        loginButton.layer.cornerRadius = 10 // for some reason, can't get the Constants button radius to work in this situation
        loginButton.backgroundColor = Constants.appColors.buttonColor
        
        signUpButton.layer.cornerRadius = 10
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = Constants.appColors.buttonColor.cgColor
        signUpButton.setTitleColor(Constants.appColors.buttonColor, for: .normal)
    }
    
    
    func transitionToSignUp() {
        // transition to home screen
        let signUpViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.signUpViewController) as? SignUpViewController
        
        view.window?.rootViewController = signUpViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToLogin() {
        // transition to home screen
        let loginViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginViewController) as? LoginViewController
        
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        self.transitionToLogin()
    }
    

    @IBAction func signUpButtonTapped(_ sender: Any) {
        self.transitionToSignUp()
    }
    
}

