//
//  Constants.swift
//  testing
//
//  Created by Austin Leung on 2/3/21.
//

import Foundation

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
}
