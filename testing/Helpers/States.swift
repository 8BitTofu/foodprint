//
//  States.swift
//  testing
//
//  Created by Austin Leung on 2/17/21.
//

import Foundation


// MARK: Welcome States

var welcomeState = -1
        
func isReturning() -> Bool {
    // checks user state to determine if returning user or new user
    if (welcomeState == 1) {
        return true
    }
            
    // if (self.welcomeState == 0)
    else {
        return false
    }
}
        
        
func resetWelcome() -> Void {
    // resets the welcomeState back to neutral
    welcomeState = -1
}
        
func setReturning() -> Void {
    // set user as a returning user
    welcomeState = 1
}
        
func setNew() -> Void {
    // set user as a new user
    welcomeState = 0
}


// MARK: Datetime States

var sameDay: Bool = true


// MARK: Update States
 
var updating: Bool = false
var updateBM = ""
