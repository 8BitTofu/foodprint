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
    
    
    
    @IBOutlet weak var addMealButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backButton.tintColor = Constants.appColors.mustard
        
        let db = Firestore.firestore()
        let userID : String = (Auth.auth().currentUser?.uid)!
        let userRef = db.collection("users").document(userID)
        
        userRef.getDocument(source: .cache) { (document, error) in
            if let document = document {
                let recipeName:String = document.get(mealRecList[recMealNum]) as! String
                
                let rdb = DBHelper()
                let recipe: Recipe = rdb.retrieve_recipe(name: recipeName )!
                
                self.recipeTitle.text = recipeName
                self.caloriesLabel.text = recipe.nutrients["calories"]
                
                let instructions:[String] = recipe.instructions
                let stringRepresentation = instructions.joined(separator:" ")
                self.instructionsLabel.text = stringRepresentation
                
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
