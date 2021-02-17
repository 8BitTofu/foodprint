//
//  Constants.swift
//  testing
//
//  Created by Austin Leung on 2/3/21.
//

import Foundation
import UIKit

struct Constants {
    
    struct Storyboard {
        
        static let homeViewController = "HomeVC"
        static let baseViewController = "baseVC"
        static let loginViewController = "loginVC"
        static let signUpViewController = "signUpVC"
        static let BodyMeasurementsViewController = "bodyMeasurementsVC"
    }
    
    struct measureList {
        static let ageList: [Int] = Array(5 ... 100)
        static let weightList: [Int] = Array(4 ... 1000)
        static let heightList: [Int] = Array(50 ... 270)
        
    }
    
    struct appColors {
        static let buttonColor = UIColor(red: 180/255, green: 70/255, blue: 30/255, alpha: 1)
    }
    
    struct appFormat {
        var buttonCornerRadius = 10
    }
}
