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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // change background color
        self.view.backgroundColor = Constants.appColors.blond
        
        signOutButton.layer.cornerRadius = 10
        signOutButton.layer.borderWidth = 1
        signOutButton.layer.borderColor = Constants.appColors.chineseOrange.cgColor
        signOutButton.setTitleColor(Constants.appColors.chineseOrange, for: .normal)
        
        
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
