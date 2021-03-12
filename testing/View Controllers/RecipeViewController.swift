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
    
    @IBOutlet weak var instructionsLabel: UILabel!
    
    @IBOutlet weak var yieldLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
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
                let stringRepresentation = instructions.joined(separator:" ")
                self.instructionsLabel.text = stringRepresentation
                
                
                
                
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
    
    
    
    
    
    // MARK: Transitions
    
    func transitionToHome() {
        // transition to home screen
        let tabbedViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabbedViewController) as? TabbedViewController
        
        view.window?.rootViewController = tabbedViewController
        view.window?.makeKeyAndVisible()
    }

}
