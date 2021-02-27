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
    
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var button4: UIButton!
    
    @IBOutlet weak var logoLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // change background color
        self.view.backgroundColor = Constants.appColors.blond
        
        logoLabel.textColor = Constants.appColors.chineseOrange
        
        
        makeGhostButton(button: signOutButton, color: Constants.appColors.pearlAqua)
        
        makeGhostButton(button: accountButton, color: Constants.appColors.chineseOrange)
        makeGhostButton(button: preferencesButton, color: Constants.appColors.chineseOrange)
        makeGhostButton(button: button3, color: Constants.appColors.chineseOrange)
        makeGhostButton(button: button4, color: Constants.appColors.chineseOrange)
        
        // Do any additional setup after loading the view.
    }
    
    
    
    // MARK: Button Actions

    @IBAction func signOutTapped(_ sender: Any) {
        // log out
        
        do { try Auth.auth().signOut() }
        catch { print("already logged out") }
        
        self.transitionToBase()
    }
    
    
    
    // MARK: Transitions
    
    func transitionToBase() {
        // transition to home screen
        let baseViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.baseViewController) as? ViewController
        
        view.window?.rootViewController = baseViewController
        view.window?.makeKeyAndVisible()
    }
    

}
