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
    
    // MARK: Buttons / Labels
    
    @IBOutlet weak var signOutButton: UIButton!
    
    @IBOutlet weak var accountButton: UIButton!
    
    @IBOutlet weak var preferencesButton: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var button4: UIButton!
    
    @IBOutlet weak var logoLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: UI / Aesthetics
        
        self.view.backgroundColor = .white
        
        logoLabel.textColor = Constants.appColors.chineseOrange
        
        
        makeGhostButton(button: signOutButton, color: Constants.appColors.pearlAqua)
        
        makeGhostButton(button: accountButton, color: Constants.appColors.chineseOrange)
        makeGhostButton(button: preferencesButton, color: Constants.appColors.chineseOrange)
        makeGhostButton(button: button3, color: Constants.appColors.chineseOrange)
        makeGhostButton(button: button4, color: Constants.appColors.chineseOrange)
        
    }
    
    
    
    // MARK: Button Actions

    @IBAction func signOutTapped(_ sender: Any) {
        // log out
        
        do { try Auth.auth().signOut() }
        catch { print("already logged out") }
        
        self.transitionToBase()
    }
    
    @IBAction func accountTapped(_ sender: Any) {
        transitionToAccount()
    }
    
    @IBAction func preferencesTapped(_ sender: Any) {
        transitionToPrefSettings()
    }
    
    
    
    
    // MARK: Transitions
    
    func transitionToBase() {
        // transition to home screen
        let baseViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.baseViewController) as? ViewController
        
        view.window?.rootViewController = baseViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    func transitionToAccount() {
        // transition to account screen
        let accountViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.accountViewController) as? AccountViewController
        
        view.window?.rootViewController = accountViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    func transitionToPrefSettings() {
        // transition to preference settings
        let prefSettingsViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.prefSettingsViewController) as? PrefSettingsViewController
        
        view.window?.rootViewController = prefSettingsViewController
        view.window?.makeKeyAndVisible()
    }
    

}
