//
//  currentUser.swift
//  testing
//
//  Created by Austin Leung on 2/18/21.
//
//  Calories Equations from: https://www.omnicalculator.com/health/bmr-harris-benedict-equation#:~:text=To%20determine%20your%20total%20daily%20calorie%20needs%2C%20multiply%20your%20BMR,Calorie%2DCalculation%20%3D%20BMR%20x%201.375


import Foundation
import FirebaseAuth
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



// MARK: Calorie Management

// COMPUTING CALORIE TOTAL
// Harris-Benedict Equation

func calcMaleCalories(weightLB: Int,  heightCM: Int, ageYR: Int, exerciseAmt: String) -> Double {
    // calculate male calories total
    
    let weightKG = Double(weightLB) / 2.205
    
    // BMR : Basal Metabolic Rate
    let BMR = (10 * weightKG) + (6.25 * Double(heightCM)) - (5 * Double(ageYR)) + 5
    var calorieTotal = -1.00
    
    switch exerciseAmt {
    case "Low":
        calorieTotal = BMR * 1.2
    case "Medium":
        calorieTotal = BMR * 1.55
    case "High":
        calorieTotal = BMR * 1.725
    default:
        calorieTotal = BMR * 1.375 // in between medium and low
    }
    
    return calorieTotal
}



func calcFemaleCalories(weightLB: Int, heightCM: Int, ageYR: Int, exerciseAmt: String) -> Double {
    // calculate female calories total
    
    let weightKG = Double(weightLB) / 2.205
    let BMR = (10 * weightKG) + (6.25 * Double(heightCM)) - (5 * Double(ageYR)) - 161
    var calorieTotal = -1.00
    
    switch exerciseAmt {
    case "Low":
        calorieTotal = BMR * 1.2
    case "Medium":
        calorieTotal = BMR * 1.55
    case "High":
        calorieTotal = BMR * 1.725
    default:
        calorieTotal = BMR * 1.375 // in between medium and low
    }
    
    return calorieTotal
}



// MARK: Calculate Leftover Calories

func calcLeftoverCals(totalCalories:Int, caloriesConsumed:Int) -> Int {
    if totalCalories > caloriesConsumed {
        return totalCalories - caloriesConsumed
    }
    else {
        return totalCalories
    }
}

