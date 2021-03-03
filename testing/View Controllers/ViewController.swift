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
    
    @IBOutlet weak var logoLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        // UI / AESTHETICS
        // change background color
        self.view.backgroundColor = .white
        
        logoLabel.textColor = Constants.appColors.orangeRed
        
        makeSolidButton(button: loginButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
        makeGhostButton(button: signUpButton, color: Constants.appColors.orangeRed)
    }
    
    
    // MARK: Transitions
    
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
    
    
    // MARK: Button Actions
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        self.transitionToLogin()
    }
    

    @IBAction func signUpButtonTapped(_ sender: Any) {
        self.transitionToSignUp()
    }
    
}

