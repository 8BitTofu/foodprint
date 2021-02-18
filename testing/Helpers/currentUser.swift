//
//  currentUser.swift
//  testing
//
//  Created by Austin Leung on 2/18/21.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore

func getCurrentUserID() -> String {
    // returns current user's userID as a string
    let userID : String = (Auth.auth().currentUser?.uid)!
    
    return userID
}


func checkUserIn() -> Bool {
    // checks if there is a user logged in at the moment
    if Auth.auth().currentUser != nil {
        // print("A user is signed in right now.")
        return true
    } else {
        // print("No user signed in.")
        return false
    }
}





