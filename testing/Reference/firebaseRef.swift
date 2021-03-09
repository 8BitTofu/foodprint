//
//  firebaseRef.swift
//  testing
//
//  Created by Austin Leung on 3/9/21.
//

import Foundation



// MARK: Import

import Firebase


//------------------------------------------------------------------

// MARK: Access Current User

/*
 
// access database
let db = Firestore.firestore()

// get the current logged in user's user id (uid)
let userID : String = (Auth.auth().currentUser?.uid)!

// get reference to user in database using uid
// we will use this to access the user's files in database
let userRef = db.collection("users").document(userID)
 
 
 CODE:
 let db = Firestore.firestore()
 let userID : String = (Auth.auth().currentUser?.uid)!
 let userRef = db.collection("users").document(userID)
 
 */

//------------------------------------------------------------------

// MARK: Getting Data from User

/*
 
 // basically use the reference
 // obtain the fields and set them to variables
 // im not entirely sure about the scope of this stuff -> you'll understand what i mean if you run
 // into any problems...
 
 // all the code in the if statement will be you accessing this data and perhaps using it
 // through your own predefined functions
 
 // the userRef will be referencing the current user reference which we got above ^^
 
 // example below obtains firstName and lastName of current user
 
 
EXAMPLE CODE:
userRef.getDocument(source: .cache) { (document, error) in
    if let document = document {
        firstName = document.get("firstname") as! String
        lastName = document.get("lastname") as! String
    } else {
        print("Cannot access current user's firstname and lastname")
    }
}
 
 */

//------------------------------------------------------------------

// MARK: Updating Data for User in Database

/*
 
 // example code below updates "gender" data field to "Male"
 
 
 EXAMPLE CODE:
 userRef.updateData([
                     "gender": "Male"
 ]) { err in
     if let err = err {
         print("Error updating gender: \(err)")
     } else {
         print("Gender successfully updated")
     }
 }
 
 */


//------------------------------------------------------------------

// MARK: Finding what data fields there are in User

// You can look at the SignUpViewController ->
// CURRENTLY AS OF 3/9/2021
// (WILL CHANGE)

// OR you can go on the Firebase site -> I have invited you both to the database
// should probably check your email and let me know though

/*
 
 let dataFields = [
     "firstname": firstName,
     "lastname": lastName,
     "email": email,
     "uid": result!.user.uid,
     "weight": 0,
     "height": 0,
     "gender": "",
     "weightChange": "",
     "exerciseAmt": "Medium", // TEMPORARY CHANGE LATER
     "totalCalories": 0,
     "caloriesConsumed": 0,
     "lastLogin": Utilities.getDate(),
     "hadBreakfast": false,
     "hadLunch": false,
     "hadDinner": false,
     "preferences": [String]()
 ] as [String : Any]
 
 */
