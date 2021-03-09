//
//  PreferencesViewController.swift
//  testing
//
//  Created by Austin Leung on 3/7/21.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class PreferencesViewController: UIViewController {

    // MARK: Buttons / Labels
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var logoLabel: UILabel!
    
    @IBOutlet weak var chooseLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var skipButton: UIButton!
    
    
    
    // MARK: Preference Buttons
    
    @IBOutlet weak var sweetsButton: UIButton!
    
    @IBOutlet weak var seafoodButton: UIButton!
    
    @IBOutlet weak var nutsButton: UIButton!
    
    @IBOutlet weak var fruitsButton: UIButton!
    
    @IBOutlet weak var soupsButton: UIButton!
    
    @IBOutlet weak var bakedButton: UIButton!
    
    @IBOutlet weak var healthyButton: UIButton!
    
    @IBOutlet weak var breadButton: UIButton!
    
    @IBOutlet weak var vegetablesButton: UIButton!
    
    @IBOutlet weak var saladsButton: UIButton!
    
    @IBOutlet weak var meatsButton: UIButton!
    
    @IBOutlet weak var pastasButton: UIButton!
    
    @IBOutlet weak var mexicanButton: UIButton!
    
    @IBOutlet weak var asianButton: UIButton!
    
    @IBOutlet weak var europeanButton: UIButton!
    
    @IBOutlet weak var caribbeanButton: UIButton!
    
    @IBOutlet weak var persianButton: UIButton!
    
    @IBOutlet weak var latinButton: UIButton!
    
    
    
    let prefList = ["sweetsButton", "seafoodButton", "nutsButton", "fruitsButton", "soupsButton", "bakedButton", "healthyButton", "breadButton", "vegetablesButton", "saladsButton", "meatsButton", "pastasButton", "mexicanButton", "asianButton", "europeanButton", "caribbeanButton", "persianButton", "latinButton"]
    
    var sweetsSelected = false
    var seafoodSelected = false
    var nutsSelected = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: UI / Aesthetics
        makeSolidButton(button: nextButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
        skipButton.setTitleColor(Constants.appColors.orangeRed, for: .normal)
        
        makeGhostButton(button: sweetsButton, color: Constants.appColors.mustard)
        makeGhostButton(button: seafoodButton, color: Constants.appColors.mustard)
        makeGhostButton(button: nutsButton, color: Constants.appColors.mustard)
        makeGhostButton(button: fruitsButton, color: Constants.appColors.mustard)
        makeGhostButton(button: soupsButton, color: Constants.appColors.mustard)
        makeGhostButton(button: bakedButton, color: Constants.appColors.mustard)
        makeGhostButton(button: healthyButton, color: Constants.appColors.mustard)
        makeGhostButton(button: breadButton, color: Constants.appColors.mustard)
        makeGhostButton(button: vegetablesButton, color: Constants.appColors.mustard)
        makeGhostButton(button: saladsButton, color: Constants.appColors.mustard)
        makeGhostButton(button: meatsButton, color: Constants.appColors.mustard)
        makeGhostButton(button: pastasButton, color: Constants.appColors.mustard)
        makeGhostButton(button: mexicanButton, color: Constants.appColors.mustard)
        makeGhostButton(button: asianButton, color: Constants.appColors.mustard)
        makeGhostButton(button: europeanButton, color: Constants.appColors.mustard)
        makeGhostButton(button: caribbeanButton, color: Constants.appColors.mustard)
        makeGhostButton(button: persianButton, color: Constants.appColors.mustard)
        makeGhostButton(button: latinButton, color: Constants.appColors.mustard)
        
    }
    
    
    // MARK: Selected Button

    @IBAction func selectSweetsButton(_ sender: UIButton) {
        if (sweetsSelected == false) {
            makeSolidButton(button: sweetsButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
            sweetsSelected = true
        }
        else {
            makeGhostButton(button: sweetsButton, color: Constants.appColors.mustard)
            sweetsSelected = false
        }
    }
    
    @IBAction func selectSeafoodButton(_ sender: UIButton) {
        if (seafoodSelected == false) {
            makeSolidButton(button: seafoodButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
            seafoodSelected = true
        }
        else {
            makeGhostButton(button: seafoodButton, color: Constants.appColors.mustard)
            seafoodSelected = false
        }
    }
    
    @IBAction func selectNutsButton(_ sender: UIButton) {
        if (nutsSelected == false) {
            makeSolidButton(button: nutsButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
            nutsSelected = true
        }
        else {
            makeGhostButton(button: nutsButton, color: Constants.appColors.mustard)
            nutsSelected = false
        }
    }
    
    
    @IBAction func nextTapped(_ sender: Any) {
        transitionToWelcome()
    }
    
    
    @IBAction func skipTapped(_ sender: Any) {
        transitionToWelcome()
    }
    
    
    @IBAction func backTapped(_ sender: Any) {
        // when clicking back button - delete all previous progress
        // on making a user account
        
        // get current user data
        let db = Firestore.firestore()
        let userID : String = (Auth.auth().currentUser?.uid)!
        
        // delete user document from users collection on Firebase
        db.collection("users").document(userID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        
        // delete user account from authentification side
        Auth.auth().currentUser?.delete(completion: { err in
            if let err = err {
                print("Error removing user: \(err)")
            } else {
                print("User successfully removed!")
            }
        })
        
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
