//
//  HomeViewController.swift
//  testing
//
//  Created by Austin Leung on 2/19/21.
//  Date/Time code provided by Stack Overflow user LorenzOliveto
//  https://stackoverflow.com/questions/35700281/date-format-in-swift
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeViewController: UIViewController {
    
    // MARK: Buttons / Labels
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var calorieCountLabel: UILabel!
    
    @IBOutlet weak var calorieLabel: UILabel!
    
    @IBOutlet weak var addMealButton: UIButton!
    
    @IBOutlet weak var refreshButton: UIButton!
    
    
    
    // MARK: Recommendation Buttons / Labels
    
    @IBOutlet weak var rec1Image: UIImageView!
    
    @IBOutlet weak var rec2Image: UIImageView!
    
    @IBOutlet weak var rec3Image: UIImageView!
    
    @IBOutlet weak var rec1NameLabel: UILabel!
    
    @IBOutlet weak var rec2NameLabel: UILabel!
    
    @IBOutlet weak var rec3NameLabel: UILabel!
    
    @IBOutlet weak var rec1CalorieLabel: UILabel!
    
    @IBOutlet weak var rec2CalorieLabel: UILabel!
    
    @IBOutlet weak var rec3CalorieLabel: UILabel!
    
    @IBOutlet weak var rec1InfoButton: UIButton!
    
    @IBOutlet weak var rec2InfoButton: UIButton!
    
    @IBOutlet weak var rec3InfoButton: UIButton!

    @IBOutlet weak var rec1Stack: UIStackView!
    
    @IBOutlet weak var rec2Stack: UIStackView!
    
    @IBOutlet weak var rec3Stack: UIStackView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // MARK: UI / Aesthetics
        
        makeSolidButton(button: addMealButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
       // makeSolidButton(button: addStepometerButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
        makeSolidButton(button: rec1InfoButton, backgroundColor: Constants.appColors.mustard, textColor: .white)
        makeSolidButton(button: rec2InfoButton, backgroundColor: Constants.appColors.mustard, textColor: .white)
        makeSolidButton(button: rec3InfoButton, backgroundColor: Constants.appColors.mustard, textColor: .white)
        makeGhostButton(button: refreshButton, color: Constants.appColors.mustard)
        
        
        self.view.backgroundColor = .white
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "fp_homepage")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)

        
        
        // DATETIME
        dateLabel.textColor = Constants.appColors.orangeRed
        calorieLabel.textColor = Constants.appColors.softGrey
        calorieCountLabel.textColor = Constants.appColors.orangeRed
        
        let dateString = Utilities.getDate()
        
        dateLabel.text = dateString
        
        
        
        // MARK: Checking Same Day
        
        var db = Firestore.firestore()
        let userID : String = getCurrentUserID()
        let userRef = db.collection("users").document(userID)
        
        // print(userID)
        
        userRef.getDocument(source: .cache) { (document, error) in
            if let document = document {
                let lastLogin = document.get("lastLogin") as! String
                
                if lastLogin != dateString {
                    // print("lastDate: " + lastLogin)
                    // print("today: " + dateString)
                    
                    userRef.updateData([
                                        "lastLogin": dateString
                    ]) { err in
                        if let err = err {
                            print("Error updating last login date: \(err)")
                        } else {
                            print("Last login date successfully updated")
                        }
                    }
                    
                    sameDay = false
                }
                else {
                    sameDay = true
                }
            } else {
                print("Cannot access current user for last login datetime")
            }
        }
        
        /*
        switch (sameDay) {
        case true:
            print("SAME DAY")
        case false:
            print("NEW/DIFFERENT DAY")
        }
         */
        
        

        
        
        
        
        
        // Personalizing Calorie Count
        var totalCalories = 0
        
        userRef.getDocument(source: .cache) { (document, error) in
            if let document = document {
                let height = document.get("height") as! Int
                let weight = document.get("weight") as! Int
                let age = document.get("age") as! Int
                let exerciseAmt = document.get("exerciseAmt") as! String
                let gender = document.get("gender") as! String
                let caloriesConsumed = document.get("caloriesConsumed") as! Int
                let hadBreakfast = document.get("hadBreakfast") as! Bool
                let hadLunch = document.get("hadLunch") as! Bool
                let hadDinner = document.get("hadDinner") as! Bool
                
                var breakfastCals: Double = 0.0
                var lunchCals: Double = 0.0
                var dinnerCals: Double = 0.0
                
                
                // MARK: Calculate Calories
                
                if (gender == "Male") {
                    totalCalories = Int(calcMaleCalories(weightLB: weight, heightCM: height, ageYR: age, exerciseAmt: exerciseAmt))
                }
                
                if (gender == "Female") {
                    totalCalories = Int(calcFemaleCalories(weightLB: weight, heightCM: height, ageYR: age, exerciseAmt: exerciseAmt))
                }
            
                var caloriesLeftover = calcLeftoverCals(totalCalories: totalCalories, caloriesConsumed: caloriesConsumed)
                
                //print("Calories leftover: \(caloriesLeftover)")
                
                // update totalCalories data field in user
                userRef.updateData([
                                    "totalCalories": totalCalories
                ]) { err in
                    if let err = err {
                        print("Error updating total calories: \(err)")
                    } else {
                        print("Total calories successfully updated")
                    }
                }
                
                
                // divide up the meals from total calories
                if (hadBreakfast == false) {
                    breakfastCals = Double(caloriesLeftover) * 0.3
                    lunchCals = Double(caloriesLeftover) * 0.4
                    dinnerCals = Double(caloriesLeftover) * 0.3
                }
                
                else if (hadLunch == false) {
                    breakfastCals = 0
                    lunchCals = Double(caloriesLeftover) * (4/7)
                    dinnerCals = Double(caloriesLeftover) * (3/7)
                }
                
                else if (hadDinner == false) {
                    breakfastCals = 0
                    lunchCals = 0
                    dinnerCals = Double(caloriesLeftover)
                }
                
                else {
                    breakfastCals = 0
                    lunchCals = 0
                    dinnerCals = 0
                }
                
                userRef.updateData([
                    "breakfastCals": Int(breakfastCals),
                    "lunchCals": Int(lunchCals),
                    "dinnerCals": Int(dinnerCals)
                ]) { err in
                    if err != nil {
                        print("Error updating individual breakfast, lunch, dinner calories")
                    } else {
                        print("Success: individual breakfast, lunch, dinner calories updated")
                    }
                }
                
                
                // if new day, reset calories consumed
                if sameDay == false {
                    userRef.updateData([
                        "caloriesConsumed": 0,
                        "hadBreakfast": false,
                        "hadLunch": false,
                        "hadDinner": false
                    ]) { err in
                        if err != nil {
                            print("Error resetting calories consumed due to new day")
                        } else {
                            print("Calories consumed reset due to new day")
                        }
                    }
                }
                
                self.setCalories(totalCalories: totalCalories, caloriesConsumed: caloriesConsumed)
                
                if refreshMeals == true {
                    var rdb = DBHelper()
                    var threeRecMeals = [String]()
                    
                    if hadBreakfast == false {
                        // MARK: Breakfast
                        
                        rdb.ranking(n: 100, calories: Double(breakfastCals))
                        let breakfastRecipes = document.get("currentRecipes") as! [String]
                        var resultSet = Set<String>()

                        while resultSet.count < 3 {
                            let randomIndex = Int.random(in: 0..<(breakfastRecipes.count))
                            resultSet.insert(breakfastRecipes[randomIndex])
                        }

                        threeRecMeals = Array(resultSet)
                    }
                    
                    
                    else if hadLunch == false {
                        // MARK: Lunch
                        
                        rdb.ranking(n: 100, calories: Double(lunchCals))
                        let lunchRecipes = document.get("currentRecipes") as! [String]
                        var resultSet = Set<String>()

                        while resultSet.count < 3 {
                            let randomIndex = Int.random(in: 0..<(lunchRecipes.count))
                            resultSet.insert(lunchRecipes[randomIndex])
                        }

                        threeRecMeals = Array(resultSet)
                    }
                    
                    
                    else if hadDinner == false {
                        // MARK: Dinner
                        
                        rdb.ranking(n: 100, calories: Double(dinnerCals))
                        let dinnerRecipes = document.get("currentRecipes") as! [String]
                        var resultSet = Set<String>()

                        while resultSet.count < 3 {
                            let randomIndex = Int.random(in: 0..<(dinnerRecipes.count))
                            resultSet.insert(dinnerRecipes[randomIndex])
                        }

                        threeRecMeals = Array(resultSet)
                    }
                    
                    else {
                        // MARK: Other
                        
                        rdb.ranking(n: 100, calories: Double(caloriesLeftover))
                        let leftoverRecipes = document.get("currentRecipes") as! [String]
                        var resultSet = Set<String>()

                        while resultSet.count < 3 {
                            let randomIndex = Int.random(in: 0..<(leftoverRecipes.count))
                            resultSet.insert(leftoverRecipes[randomIndex])
                        }

                        threeRecMeals = Array(resultSet)
                    }
                    
                    
                    // MARK: Recommendations
                    
                    var index = 1
                    
                    // print("three meals: \(threeRecMeals)")
                    
                    for recommendation in threeRecMeals {
                        let recipe: Recipe = rdb.retrieve_recipe(name: recommendation)!
                        rdb.print_recipe(recipe: recipe)
                        
                        if index == 1 {
                            userRef.updateData([
                                "mealRec1": recommendation
                            ])
                            
                            
                            let url = URL(string: recipe.image)!

                            // Create Data Task
                            let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
                                if let data = data {
                                    DispatchQueue.main.async {
                                        // Create Image and Update Image View
                                        self?.rec1Image.image = UIImage(data: data)
                                    }
                                }
                            }

                            // Start Data Task
                            dataTask.resume()
                            
                            
                            self.rec1NameLabel.text = recommendation
                            self.rec1CalorieLabel.text = recipe.nutrients["calories"]
                            // print("rec1Cal: " + String(recipe.nutrients["calories"] ?? "0000"))
                        }
                        
                        else if index == 2 {
                            userRef.updateData([
                                "mealRec2": recommendation
                            ])
                            
                            
                            let url = URL(string: recipe.image)!

                            // Create Data Task
                            let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
                                if let data = data {
                                    DispatchQueue.main.async {
                                        // Create Image and Update Image View
                                        self?.rec2Image.image = UIImage(data: data)
                                    }
                                }
                            }

                            // Start Data Task
                            dataTask.resume()
                            
                            
                            self.rec2NameLabel.text = recommendation
                            self.rec2CalorieLabel.text = recipe.nutrients["calories"]
                            // print("rec2Cal: " + String(recipe.nutrients["calories"] ?? "0000"))
                        }
                        
                        else if index == 3 {
                            userRef.updateData([
                                "mealRec3": recommendation
                            ])
                            
                            
                            let url = URL(string: recipe.image)!

                            // Create Data Task
                            let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
                                if let data = data {
                                    DispatchQueue.main.async {
                                        // Create Image and Update Image View
                                        self?.rec3Image.image = UIImage(data: data)
                                    }
                                }
                            }
                            

                            // Start Data Task
                            dataTask.resume()
                            
                            
                            self.rec3NameLabel.text = recommendation
                            self.rec3CalorieLabel.text = recipe.nutrients["calories"]
                            // print("rec3Cal: " + String(recipe.nutrients["calories"] ?? "0000"))
                        }
                        
                        // increment
                        index = index + 1
                    }
                    
                    // reset
                    refreshMeals = false
                }
                
                else {
                    // if regular not updating
                    
                    userRef.getDocument(source: .cache) { (document, error) in
                        if let document = document {
                            let mealRec1 = document.get("mealRec1") as! String
                            let mealRec2 = document.get("mealRec2") as! String
                            let mealRec3 = document.get("mealRec3") as! String
                            
                            let rdb = DBHelper()
                            
                            self.rec1NameLabel.text = mealRec1
                            self.rec2NameLabel.text = mealRec2
                            self.rec3NameLabel.text = mealRec3
                            
                            let rec1: Recipe = rdb.retrieve_recipe(name: mealRec1)!
                            let rec2: Recipe = rdb.retrieve_recipe(name: mealRec2)!
                            let rec3: Recipe = rdb.retrieve_recipe(name: mealRec3)!
                            
                            self.rec1CalorieLabel.text = rec1.nutrients["calories"]
                            self.rec2CalorieLabel.text = rec2.nutrients["calories"]
                            self.rec3CalorieLabel.text = rec3.nutrients["calories"]
                            
                            
                            let rec1url = URL(string: rec1.image)!

                            // Create Data Task
                            let dataTask1 = URLSession.shared.dataTask(with: rec1url) { [weak self] (data, _, _) in
                                if let data = data {
                                    DispatchQueue.main.async {
                                        // Create Image and Update Image View
                                        self?.rec1Image.image = UIImage(data: data)
                                    }
                                }
                            }
                            
                            dataTask1.resume()
                            
                            let rec2url = URL(string: rec2.image)!

                            // Create Data Task
                            let dataTask2 = URLSession.shared.dataTask(with: rec2url) { [weak self] (data, _, _) in
                                if let data = data {
                                    DispatchQueue.main.async {
                                        // Create Image and Update Image View
                                        self?.rec2Image.image = UIImage(data: data)
                                    }
                                }
                            }
                            
                            dataTask2.resume()
                            
                            let rec3url = URL(string: rec3.image)!

                            // Create Data Task
                            let dataTask3 = URLSession.shared.dataTask(with: rec3url) { [weak self] (data, _, _) in
                                if let data = data {
                                    DispatchQueue.main.async {
                                        // Create Image and Update Image View
                                        self?.rec3Image.image = UIImage(data: data)
                                    }
                                }
                            }
                            
                            dataTask3.resume()
                            
                            
                            
                        } else {
                            print("Cannot access redo recommendation labels")
                        }
                    }
                    
                }
                
            }
        }
        
        
        
    }
    
    
    
    
    // MARK: Button Actions
    
    @IBAction func addMealTapped(_ sender: Any) {
        transitionToAddMeal()
    }
    
    @IBAction func info1Tapped(_ sender: Any) {
        recMealNum = 0
        transitionToRecipeView()
    }
    
    @IBAction func info2Tapped(_ sender: Any) {
        recMealNum = 1
        transitionToRecipeView()
    }
    
    @IBAction func info3Tapped(_ sender: Any) {
        recMealNum = 2
        transitionToRecipeView()
    }
    
    @IBAction func refreshTapped(_ sender: Any) {
        var db = Firestore.firestore()
        let userID : String = getCurrentUserID()
        let userRef = db.collection("users").document(userID)
        
        
        userRef.getDocument(source: .cache) { (document, error) in
            if let document = document {
                let hadBreakfast = document.get("hadBreakfast") as! Bool
                let hadLunch = document.get("hadLunch") as! Bool
                let hadDinner = document.get("hadDinner") as! Bool
                let breakfastCals = document.get("breakfastCals") as! Int
                let lunchCals = document.get("lunchCals") as! Int
                let dinnerCals = document.get("dinnerCals") as! Int
                let totalCalories = document.get("totalCalories") as! Int
                let caloriesConsumed = document.get("caloriesConsumed") as! Int
                
                var caloriesLeftover = calcLeftoverCals(totalCalories: totalCalories, caloriesConsumed: caloriesConsumed)
                
                var rdb = DBHelper()
                var threeRecMeals = [String]()
                
                if hadBreakfast == false {
                    // MARK: Breakfast
                    
                    rdb.ranking(n: 100, calories: Double(breakfastCals))
                    let breakfastRecipes = document.get("currentRecipes") as! [String]
                    var resultSet = Set<String>()

                    while resultSet.count < 3 {
                        let randomIndex = Int.random(in: 0..<(breakfastRecipes.count))
                        resultSet.insert(breakfastRecipes[randomIndex])
                    }

                    threeRecMeals = Array(resultSet)
                }
                
                
                else if hadLunch == false {
                    // MARK: Lunch
                    
                    rdb.ranking(n: 100, calories: Double(lunchCals))
                    let lunchRecipes = document.get("currentRecipes") as! [String]
                    var resultSet = Set<String>()

                    while resultSet.count < 3 {
                        let randomIndex = Int.random(in: 0..<(lunchRecipes.count))
                        resultSet.insert(lunchRecipes[randomIndex])
                    }

                    threeRecMeals = Array(resultSet)
                }
                
                
                else if hadDinner == false {
                    // MARK: Dinner
                    
                    rdb.ranking(n: 100, calories: Double(dinnerCals))
                    let dinnerRecipes = document.get("currentRecipes") as! [String]
                    var resultSet = Set<String>()

                    while resultSet.count < 3 {
                        let randomIndex = Int.random(in: 0..<(dinnerRecipes.count))
                        resultSet.insert(dinnerRecipes[randomIndex])
                    }

                    threeRecMeals = Array(resultSet)
                }
                
                else {
                    // MARK: Other
                    
                    rdb.ranking(n: 100, calories: Double(caloriesLeftover))
                    let leftoverRecipes = document.get("currentRecipes") as! [String]
                    var resultSet = Set<String>()

                    while resultSet.count < 3 {
                        let randomIndex = Int.random(in: 0..<(leftoverRecipes.count))
                        resultSet.insert(leftoverRecipes[randomIndex])
                    }

                    threeRecMeals = Array(resultSet)
                }
                
                
                // MARK: Recommendations
                
                var index = 1
                
                // print("three meals: \(threeRecMeals)")
                
                for recommendation in threeRecMeals {
                    let recipe: Recipe = rdb.retrieve_recipe(name: recommendation)!
                    rdb.print_recipe(recipe: recipe)
                    
                    if index == 1 {
                        userRef.updateData([
                            "mealRec1": recommendation
                        ])
                        
                        
                        let url = URL(string: recipe.image)!

                        // Create Data Task
                        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
                            if let data = data {
                                DispatchQueue.main.async {
                                    // Create Image and Update Image View
                                    self?.rec1Image.image = UIImage(data: data)
                                }
                            }
                        }

                        // Start Data Task
                        dataTask.resume()
                        
                        
                        self.rec1NameLabel.text = recommendation
                        self.rec1CalorieLabel.text = recipe.nutrients["calories"]
                        // print("rec1Cal: " + String(recipe.nutrients["calories"] ?? "0000"))
                    }
                    
                    else if index == 2 {
                        userRef.updateData([
                            "mealRec2": recommendation
                        ])
                        
                        
                        let url = URL(string: recipe.image)!

                        // Create Data Task
                        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
                            if let data = data {
                                DispatchQueue.main.async {
                                    // Create Image and Update Image View
                                    self?.rec2Image.image = UIImage(data: data)
                                }
                            }
                        }

                        // Start Data Task
                        dataTask.resume()
                        
                        
                        self.rec2NameLabel.text = recommendation
                        self.rec2CalorieLabel.text = recipe.nutrients["calories"]
                        // print("rec2Cal: " + String(recipe.nutrients["calories"] ?? "0000"))
                    }
                    
                    else if index == 3 {
                        userRef.updateData([
                            "mealRec3": recommendation
                        ])
                        
                        
                        let url = URL(string: recipe.image)!

                        // Create Data Task
                        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
                            if let data = data {
                                DispatchQueue.main.async {
                                    // Create Image and Update Image View
                                    self?.rec3Image.image = UIImage(data: data)
                                }
                            }
                        }
                        

                        // Start Data Task
                        dataTask.resume()
                        
                        
                        self.rec3NameLabel.text = recommendation
                        self.rec3CalorieLabel.text = recipe.nutrients["calories"]
                        // print("rec3Cal: " + String(recipe.nutrients["calories"] ?? "0000"))
                    }
                    
                    // increment
                    index = index + 1
                }
            }
        }
    }
    
    
    
    
    
    // MARK: Set Calories
    
    func setCalories(totalCalories: Int, caloriesConsumed: Int) -> Void {
        var calText = ""
        
        calText += String(caloriesConsumed) + " / " + String(totalCalories)
        calorieCountLabel.text = calText
    }
    
    
    // MARK: Transitions
    
    func transitionToAddMeal() {
        // transition to account screen
        let addMealViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.addMealViewController) as? AddMealViewController
        
        view.window?.rootViewController = addMealViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToRecipeView() {
        // transition to account screen
        let recipeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.recipeViewController) as? RecipeViewController
        
        view.window?.rootViewController = recipeViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToHome() {
        // transition to home screen
        let tabbedViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabbedViewController) as? TabbedViewController
        
        view.window?.rootViewController = tabbedViewController
        view.window?.makeKeyAndVisible()
    }
    
}
