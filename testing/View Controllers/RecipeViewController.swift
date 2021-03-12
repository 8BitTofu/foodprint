//
//  RecipeViewController.swift
//  testing
//
//  Created by Austin Leung on 3/10/21.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class RecipeViewController: UIViewController {

    // MARK: Buttons / Labels
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var recipeTitle: UILabel!
    
    @IBOutlet weak var caloriesLabel: UILabel!
    
    @IBOutlet weak var instructionsLabel: UITextView!
    
    @IBOutlet weak var yieldLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    @IBOutlet weak var instructLabel: UILabel!
    
    @IBOutlet weak var ingredientsView: UITextView!
    
    
    @IBOutlet weak var logoLabel: UILabel!
    
    @IBOutlet weak var addMealButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: UI / Aesthetics
        
        backButton.tintColor = Constants.appColors.mustard
        logoLabel.textColor = Constants.appColors.orangeRed
        makeSolidLabel(label: recipeTitle, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
        makeSolidButton(button: addMealButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
        makeSolidLabel(label: caloriesLabel, backgroundColor: Constants.appColors.mustard
                       , textColor: Constants.appColors.softBlack)
        makeSolidLabel(label: yieldLabel, backgroundColor: Constants.appColors.mustard
                       , textColor: Constants.appColors.softBlack)
        makeSolidLabel(label: timeLabel, backgroundColor: Constants.appColors.mustard
                       , textColor: Constants.appColors.softBlack)
        
        makeSolidLabel(label: ingredientsLabel, backgroundColor: Constants.appColors.mustard
                       , textColor: Constants.appColors.softBlack)
        makeSolidLabel(label: instructLabel, backgroundColor: Constants.appColors.mustard
                       , textColor: Constants.appColors.softBlack)
        
        
        caloriesLabel.numberOfLines = 0
        yieldLabel.numberOfLines = 0
        timeLabel.numberOfLines = 0
        
        
        let db = Firestore.firestore()
        let userID : String = (Auth.auth().currentUser?.uid)!
        let userRef = db.collection("users").document(userID)
        
        // MARK: Setting Labels
        
        userRef.getDocument(source: .cache) { (document, error) in
            if let document = document {
                let recipeName:String = document.get(mealRecList[recMealNum]) as! String
                
                let rdb = DBHelper()
                let recipe: Recipe = rdb.retrieve_recipe(name: recipeName )!
                
                self.recipeTitle.text = recipeName
                self.caloriesLabel.text = recipe.nutrients["calories"]
                self.yieldLabel.text = recipe.yields
                self.timeLabel.text = recipe.time
                
                let instructions:[String] = recipe.instructions
                let instructionsRepresentation = instructions.joined(separator:"\n")
                self.instructionsLabel.text = instructionsRepresentation
                
                let ingredients:[String] = recipe.ingredients
                let ingredientsRepresentation = ingredients.joined(separator:"\n")
                self.ingredientsView.text = ingredientsRepresentation
                
                
                
                
                // MARK: Image
                
                let url = URL(string: recipe.image)!

                // Create Data Task
                let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
                    if let data = data {
                        DispatchQueue.main.async {
                            // Create Image and Update Image View
                            self?.recipeImage.image = UIImage(data: data)
                        }
                    }
                }
                
                dataTask.resume()
                
            } else {
                print("Cannot access meal info")
            }
        }
    }
    
    
    
    
    // MARK: Button Actions
    
    @IBAction func backTapped(_ sender: Any) {
        transitionToHome()
    }
    
    @IBAction func addMealTapped(_ sender: Any) {
        let db = Firestore.firestore()
        let userID : String = (Auth.auth().currentUser?.uid)!
        let userRef = db.collection("users").document(userID)
        
        userRef.getDocument(source: .cache) { (document, error) in
            if let document = document {
                let recipeName:String = document.get(mealRecList[recMealNum]) as! String
                
                let rdb = DBHelper()
                let recipe: Recipe = rdb.retrieve_recipe(name: recipeName )!
                
                let recipeCalString:String = recipe.nutrients["calories"]!
                
                let delimiter = " "
                let caloriesString = recipeCalString.components(separatedBy: delimiter)
                let mealCalories = String(caloriesString[0])
                let mealCaloriesDouble = Double(mealCalories) ?? 0.0
                let mealCaloriesInt = Int(mealCaloriesDouble)

                
                userRef.getDocument(source: .cache) { (document, error) in
                    if let document = document {
                        let currentCaloriesConsumed = document.get("caloriesConsumed") as! Int
                        let currentMealNum = document.get("mealNum") as! Int
                        let hadBreakfast = document.get("hadBreakfast") as! Bool
                        let hadLunch = document.get("hadLunch") as! Bool
                        let hadDinner = document.get("hadDinner") as! Bool
                        
                        // update the height/weight/age of current user (get input)
                        userRef.updateData([
                            "caloriesConsumed": currentCaloriesConsumed + mealCaloriesInt,
                            "mealNum": currentMealNum + 1
                        ]) { err in
                            if let err = err {
                                print("Error adding new meal via info: \(err)")
                            } else {
                                print("New meal successfully added via info")
                            }
                        }
                        
                        
                        // update which meal has been eaten
                        
                        if (hadBreakfast == false) {
                            userRef.updateData([
                                "hadBreakfast": true
                            ]) { err in
                                if let err = err {
                                    print("Error updating hadBreakfast: \(err)")
                                } else {
                                    print("hadBreakfast successfully updated")
                                }
                            }
                        }
                        
                        else if (hadLunch == false) {
                            userRef.updateData([
                                "hadLunch": true
                            ]) { err in
                                if let err = err {
                                    print("Error updating hadLunch: \(err)")
                                } else {
                                    print("hadLunch successfully updated")
                                }
                            }
                        }
                        
                        else if (hadDinner == false) {
                            userRef.updateData([
                                "hadDinner": true
                            ]) { err in
                                if let err = err {
                                    print("Error updating hadDinner: \(err)")
                                } else {
                                    print("hadDinner successfully updated")
                                }
                            }
                        }
                        
                        
                    } else {
                        print("Cannot access current user's data (Adding Recipe Meal via Info)")
                    }
                }

            }
        }

        refreshMeals = false // dont refresh?
        
        
        successAdd()
    }
    
    
    func successAdd() {
        addMealButton.setTitle("Success!", for: .normal)
        makeSolidButton(button: addMealButton, backgroundColor: .green, textColor: .white)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let tabbedViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabbedViewController) as? TabbedViewController
            
            self.view.window?.rootViewController = tabbedViewController
            self.view.window?.makeKeyAndVisible()
        }
    }
    
    
    
    // MARK: Transitions
    
    func transitionToHome() {
        // transition to home screen
        let tabbedViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabbedViewController) as? TabbedViewController
        
        view.window?.rootViewController = tabbedViewController
        view.window?.makeKeyAndVisible()
    }

}
