//
//  PrefSettingsViewController.swift
//  testing
//
//  Created by Austin Leung on 3/9/21.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class PrefSettingsViewController: UIViewController {
    
    // MARK: Buttons / Labels
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var logoLabel: UILabel!
    
    @IBOutlet weak var preferenceLabel: UILabel!
    
    @IBOutlet weak var updateButton: UIButton!
    
    
    
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
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: UI / Aesthetics
        
        makeSolidButton(button: updateButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
        backButton.tintColor = Constants.appColors.mustard
        logoLabel.textColor = Constants.appColors.orangeRed
        
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
        
        
        var prefList = [String]()
        
        // access current user information
        let db = Firestore.firestore()
        let userID : String = (Auth.auth().currentUser?.uid)!
        let userRef = db.collection("users").document(userID)
        
        userRef.getDocument(source: .cache) { (document, error) in
            if let document = document {
                prefList = document.get("preferences") as! [String]
                
                
                // MARK: Setting User's Pre-Selected Preferences
                
                for preference in prefList {
                    if preference == "sweets" {
                        makeSolidButton(button: self.sweetsButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
                        prefStateList["sweets"] = true
                    }
                    
                    if preference == "seafood" {
                        makeSolidButton(button: self.seafoodButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
                        prefStateList["seafood"] = true
                    }
                    
                    if preference == "nuts" {
                        makeSolidButton(button: self.nutsButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
                        prefStateList["nuts"] = true
                    }
                    
                    if preference == "fruits" {
                        makeSolidButton(button: self.fruitsButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
                        prefStateList["fruits"] = true
                    }
                    
                    if preference == "soups" {
                        makeSolidButton(button: self.soupsButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
                        prefStateList["soups"] = true
                    }
                    
                    if preference == "baked" {
                        makeSolidButton(button: self.bakedButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
                        prefStateList["baked"] = true
                    }
                    
                    if preference == "healthy" {
                        makeSolidButton(button: self.healthyButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
                        prefStateList["healthy"] = true
                    }
                    
                    if preference == "bread" {
                        makeSolidButton(button: self.breadButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
                        prefStateList["bread"] = true
                    }
                    
                    if preference == "vegetables" {
                        makeSolidButton(button: self.vegetablesButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
                        prefStateList["vegetables"] = true
                    }
                    
                    if preference == "salads" {
                        makeSolidButton(button: self.saladsButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
                        prefStateList["salads"] = true
                    }
                    
                    if preference == "meats" {
                        makeSolidButton(button: self.meatsButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
                        prefStateList["meats"] = true
                    }
                    
                    if preference == "pastas" {
                        makeSolidButton(button: self.pastasButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
                        prefStateList["pastas"] = true
                    }
                    
                    if preference == "mexican" {
                        makeSolidButton(button: self.mexicanButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
                        prefStateList["mexican"] = true
                    }
                    
                    if preference == "asian" {
                        makeSolidButton(button: self.asianButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
                        prefStateList["asian"] = true
                    }
                    
                    if preference == "european" {
                        makeSolidButton(button: self.europeanButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
                        prefStateList["european"] = true
                    }
                    
                    if preference == "caribbean" {
                        makeSolidButton(button: self.caribbeanButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
                        prefStateList["caribbean"] = true
                    }
                    
                    if preference == "persian" {
                        makeSolidButton(button: self.persianButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
                        prefStateList["persian"] = true
                    }
                }
            } else {
                print("Cannot access current user's preferences")
            }
        }
    }
    
    
    
    
    // MARK: Preference Button Actions
    
    @IBAction func sweetsTapped(_ sender: Any) {
        if (prefStateList["sweets"] == false) {
            makeSolidButton(button: sweetsButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
            prefStateList["sweets"] = true
        }
        else {
            makeGhostButton(button: sweetsButton, color: Constants.appColors.mustard)
            prefStateList["sweets"] = false
        }
    }
    
    
    @IBAction func seafoodTapped(_ sender: Any) {
        if (prefStateList["seafood"] == false) {
            makeSolidButton(button: seafoodButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
            prefStateList["seafood"] = true
        }
        else {
            makeGhostButton(button: seafoodButton, color: Constants.appColors.mustard)
            prefStateList["seafood"] = false
        }
    }
    
    
    @IBAction func nutsTapped(_ sender: Any) {
        if (prefStateList["nuts"] == false) {
            makeSolidButton(button: nutsButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
            prefStateList["nuts"] = true
        }
        else {
            makeGhostButton(button: nutsButton, color: Constants.appColors.mustard)
            prefStateList["nuts"] = false
        }
    }
    
    
    @IBAction func fruitsTapped(_ sender: Any) {
        if (prefStateList["fruits"] == false) {
            makeSolidButton(button: fruitsButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
            prefStateList["fruits"] = true
        }
        else {
            makeGhostButton(button: fruitsButton, color: Constants.appColors.mustard)
            prefStateList["fruits"] = false
        }
    }
    
    
    @IBAction func soupsTapped(_ sender: Any) {
        if (prefStateList["soups"] == false) {
            makeSolidButton(button: soupsButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
            prefStateList["soups"] = true
        }
        else {
            makeGhostButton(button: soupsButton, color: Constants.appColors.mustard)
            prefStateList["soups"] = false
        }
    }
    
    
    @IBAction func bakedTapped(_ sender: Any) {
        if (prefStateList["baked"] == false) {
            makeSolidButton(button: bakedButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
            prefStateList["baked"] = true
        }
        else {
            makeGhostButton(button: bakedButton, color: Constants.appColors.mustard)
            prefStateList["baked"] = false
        }
    }
    
    
    @IBAction func healthyTapped(_ sender: Any) {
        if (prefStateList["healthy"] == false) {
            makeSolidButton(button: healthyButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
            prefStateList["healthy"] = true
        }
        else {
            makeGhostButton(button: healthyButton, color: Constants.appColors.mustard)
            prefStateList["healthy"] = false
        }
    }
    
    
    @IBAction func breadTapped(_ sender: Any) {
        if (prefStateList["bread"] == false) {
            makeSolidButton(button: breadButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
            prefStateList["bread"] = true
        }
        else {
            makeGhostButton(button: breadButton, color: Constants.appColors.mustard)
            prefStateList["bread"] = false
        }
    }
    
    
    @IBAction func vegetablesTapped(_ sender: Any) {
        if (prefStateList["vegetables"] == false) {
            makeSolidButton(button: vegetablesButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
            prefStateList["vegetables"] = true
        }
        else {
            makeGhostButton(button: vegetablesButton, color: Constants.appColors.mustard)
            prefStateList["vegetables"] = false
        }
    }
    
    
    @IBAction func saladsTapped(_ sender: Any) {
        if (prefStateList["salads"] == false) {
            makeSolidButton(button: saladsButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
            prefStateList["salads"] = true
        }
        else {
            makeGhostButton(button: saladsButton, color: Constants.appColors.mustard)
            prefStateList["salads"] = false
        }
    }
    
    
    @IBAction func meatsTapped(_ sender: Any) {
        if (prefStateList["meats"] == false) {
            makeSolidButton(button: meatsButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
            prefStateList["meats"] = true
        }
        else {
            makeGhostButton(button: meatsButton, color: Constants.appColors.mustard)
            prefStateList["meats"] = false
        }
    }
    
    
    @IBAction func pastasTapped(_ sender: Any) {
        if (prefStateList["pastas"] == false) {
            makeSolidButton(button: pastasButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
            prefStateList["pastas"] = true
        }
        else {
            makeGhostButton(button: pastasButton, color: Constants.appColors.mustard)
            prefStateList["pastas"] = false
        }
    }
    
    
    @IBAction func mexicanTapped(_ sender: Any) {
        if (prefStateList["mexican"] == false) {
            makeSolidButton(button: mexicanButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
            prefStateList["mexican"] = true
        }
        else {
            makeGhostButton(button: mexicanButton, color: Constants.appColors.mustard)
            prefStateList["mexican"] = false
        }
    }
    
    
    @IBAction func asianTapped(_ sender: Any) {
        if (prefStateList["asian"] == false) {
            makeSolidButton(button: asianButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
            prefStateList["asian"] = true
        }
        else {
            makeGhostButton(button: asianButton, color: Constants.appColors.mustard)
            prefStateList["asian"] = false
        }
    }
    
    
    @IBAction func europeanTapped(_ sender: Any) {
        if (prefStateList["european"] == false) {
            makeSolidButton(button: europeanButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
            prefStateList["european"] = true
        }
        else {
            makeGhostButton(button: europeanButton, color: Constants.appColors.mustard)
            prefStateList["european"] = false
        }
    }
    
    
    @IBAction func caribbeanTapped(_ sender: Any) {
        if (prefStateList["caribbean"] == false) {
            makeSolidButton(button: caribbeanButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
            prefStateList["caribbean"] = true
        }
        else {
            makeGhostButton(button: caribbeanButton, color: Constants.appColors.mustard)
            prefStateList["caribbean"] = false
        }
    }
    
    
    @IBAction func persianTapped(_ sender: Any) {
        if (prefStateList["persian"] == false) {
            makeSolidButton(button: persianButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
            prefStateList["persian"] = true
        }
        else {
            makeGhostButton(button: persianButton, color: Constants.appColors.mustard)
            prefStateList["persian"] = false
        }
    }
    
    
    @IBAction func latinTapped(_ sender: Any) {
        if (prefStateList["latin"] == false) {
            makeSolidButton(button: latinButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
            prefStateList["latin"] = true
        }
        else {
            makeGhostButton(button: latinButton, color: Constants.appColors.mustard)
            prefStateList["latin"] = false
        }
    }
    
    
    

    // MARK: Button Actions
    
    @IBAction func backButtonTapped(_ sender: Any) {
        transitionToHome()
    }
    
    @IBAction func updateTapped(_ sender: Any) {
        // check and input the states that are TRUE
        // this means that the user has selected those TRUE state preferences
        var prefList = [String]()
        
        for prefState in prefStateList.keys {
            if prefStateList[prefState] == true {
                prefList.append(prefState)
            }
        }
        
        // access current user information
        let db = Firestore.firestore()
        let userID : String = (Auth.auth().currentUser?.uid)!
        let userRef = db.collection("users").document(userID)

        
        // update the height/weight/age of current user (get input)
        userRef.updateData([
                            "preferences": prefList
        ]) { err in
            if let err = err {
                print("Error updating preferences: \(err)")
            } else {
                print("Preferences successfully updated")
            }
        }
        
        refreshMeals = true
        transitionToHome()
    }
    
    
    // MARK: Transitions
    
    func transitionToSettings() {
        // transition to account screen
        let settingsViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.settingsViewController) as? SettingsViewController
        
        view.window?.rootViewController = settingsViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToHome() {
        // transition to home screen
        let tabbedViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabbedViewController) as? TabbedViewController
        
        view.window?.rootViewController = tabbedViewController
        view.window?.makeKeyAndVisible()
    }
    
}
