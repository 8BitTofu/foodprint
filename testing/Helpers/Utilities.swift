//
//  Utilities.swift
//  customauth
//
//  Created by Christopher Ching on 2019-05-09.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    
    static func isHeightValid(_ height : Int) -> Bool {
        
        if Constants.measureList.heightList.contains(height) {
            return true
        }
        else {
            return false
        }
    }
    
    
    static func isWeightValid(_ weight : Int) -> Bool {
        
        if Constants.measureList.weightList.contains(weight) {
            return true
        }
        else {
            return false
        }
    }
    
    
    static func isAgeValid(_ age : Int) -> Bool {
        
        if Constants.measureList.ageList.contains(age) {
            return true
        }
        else {
            return false
        }
    }
    
    
    
}
