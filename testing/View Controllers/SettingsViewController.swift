//
//  SettingsViewController.swift
//  testing
//
//  Created by Austin Leung on 2/19/21.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var signOutButton: UIButton!
    
    @IBOutlet weak var accountButton: UIButton!
    
    @IBOutlet weak var preferencesButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // change background color
        self.view.backgroundColor = Constants.appColors.blond
        
        makeGhostButton(button: signOutButton, color: Constants.appColors.chineseOrange)
        makeGhostButton(button: accountButton, color: Constants.appColors.chineseOrange)
        makeGhostButton(button: preferencesButton, color: Constants.appColors.chineseOrange)
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func signOutTapped(_ sender: Any) {
        // log out
        
        do { try Auth.auth().signOut() }
        catch { print("already logged out") }
        
        self.transitionToBase()
    }
    
    
    func transitionToBase() {
        // transition to home screen
        let baseViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.baseViewController) as? ViewController
        
        view.window?.rootViewController = baseViewController
        view.window?.makeKeyAndVisible()
    }
    

}
