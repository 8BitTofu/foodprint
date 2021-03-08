//
//  PreferencesViewController.swift
//  testing
//
//  Created by Austin Leung on 3/7/21.
//

import UIKit

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
    

}
