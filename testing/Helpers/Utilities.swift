//
//  Utilities.swift
//
//  Password authentication created by Christopher Chin on 2019-05-09
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
    
    static func getDate() -> String {
        // get datetime
        
        let formatter = DateFormatter()
        //2016-12-08 03:37:22 +0000
        formatter.dateFormat = "MM.dd.yyyy"
        let now = Date()
        let dateString = formatter.string(from:now)
        
        return dateString
    }
    
    
    
}
