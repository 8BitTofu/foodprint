//
//  Constants.swift
//  testing
//
//  Created by Austin Leung on 2/3/21.
//

import Foundation
import UIKit

class Constants {
    
    class Storyboard {
        
        static let welcomeViewController = "welcomeVC"
        static let tabbedViewController = "tabbedVC"
        static let homeViewController = "homeVC"
        static let stepometerViewController = "stepometerVC"
        static let settingsViewController = "settingsVC"
        static let baseViewController = "baseVC"
        static let loginViewController = "loginVC"
        static let signUpViewController = "signUpVC"
        static let bodyMeasurementsViewController = "bodyMeasurementsVC"
        static let genderViewController = "genderVC"
        static let weightViewController = "weightVC"
        static let accountViewController = "accountVC"
        static let deleteAccountViewController = "deleteAccountVC"
        static let addMealViewController = "addMealVC"
        static let updateBMViewController = "updateBMVC"
        static let preferencesViewController = "preferencesVC"
        static let prefSettingsViewController = "prefSettingsVC"
        static let progressViewController = "progressVC"
        static let recipeViewController = "recipeVC"
        
    }
    
    class measureList {
        static let ageList: [Int] = Array(5 ... 100)
        static let weightList: [Int] = Array(4 ... 1000)
        static let heightList: [Int] = Array(50 ... 270)
        
    }
    
    class appColors {
        static let chineseOrange = UIColor(red: 236/255, green: 110/255, blue: 69/255, alpha: 1)
        static let blond = UIColor(red: 255/255, green: 245/255, blue: 194/255, alpha: 1)
        static let mediumSpringBud = UIColor(red: 211/255, green: 227/255, blue: 194/255, alpha: 1)
        static let pearlAqua = UIColor(red: 141/255, green: 204/255, blue: 193/255, alpha: 1)
        static let softBlack = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        
        static let softGrey = UIColor(red: 158/255, green: 158/255, blue: 158/255, alpha: 1)
        
        static let orangeRed = UIColor(red: 245/255, green: 70/255, blue: 4/255, alpha: 1)
        
        static let mustard = UIColor(red: 255/255, green: 203/255, blue: 0/255, alpha: 1)
        
        // static let primaryWarm = UIColor(red: 255/255, green: 69/255, blue: 0/255, alpha: 1)
        // UIColor(red: 180/255, green: 70/255, blue: 30/255, alpha: 1)
        // static let secondaryWarm = UIColor(red: 210/255, green: 100/255, blue: 60/220, alpha: 1)
    }
    
    class appFormat {
        var buttonCornerRadius = 10
    }
}
