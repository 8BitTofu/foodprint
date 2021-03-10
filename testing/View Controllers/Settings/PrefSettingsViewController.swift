//
//  PrefSettingsViewController.swift
//  testing
//
//  Created by Austin Leung on 3/9/21.
//

import UIKit

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
        
        
    }
    

    // MARK: Button Actions
    
    @IBAction func backButtonTapped(_ sender: Any) {
    }
    
    @IBAction func updateTapped(_ sender: Any) {
    }
    
    
    // MARK: Transitions
    
    func transitionToSettings() {
        // transition to account screen
        let accountViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.accountViewController) as? AccountViewController
        
        view.window?.rootViewController = accountViewController
        view.window?.makeKeyAndVisible()
    }
    
}
