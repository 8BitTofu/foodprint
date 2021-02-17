//
//  ViewController.swift
//  testing
//
//  Created by Austin Leung on 2/1/21.
//

import UIKit
import Foundation
import HealthKit

class ViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        // UI / AESTHETICS
        loginButton.layer.cornerRadius = 10 // for some reason, can't get the Constants button radius to work in this situation
        loginButton.backgroundColor = Constants.appColors.buttonColor
        
        signUpButton.layer.cornerRadius = 10
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = Constants.appColors.buttonColor.cgColor
        signUpButton.setTitleColor(Constants.appColors.buttonColor, for: .normal)
         
        
        
        // failed spoonacular code below - REMOVE IF NECESSARY
        // I ONLY KEPT IT FOR REFERENCE
        
        /*
        // URL
        let url = URL(string: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/findByNutrients?number=3&maxCalories=1000&minCalories=500&limitLicense=false")
        
        guard url != nil else {
            print("error getting url")
            return
        }
        
        // headers
        let headers = [
            "x-rapidapi-key": "616e390104mshe591342af78d1e6p10af43jsn9eb51e05c753",
            "x-rapidapi-host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
        ]
        
        // URL request
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        request.allHTTPHeaderFields = headers
        
        // specify the body
        let jsonObject = ["id":89442,
                          "title":"Tuna Casserole",
                          "image":"https://spoonacular.com/recipeImages/89442-312x231.jpg",
                          "imageType":"jpg",
                          "calories":547,
                          "protein":"38g",
                          "fat":"11g",
                          "carbs":"73g"] as [String : Any]
        
        do {
            let requestBody = try JSONSerialization.data(withJSONObject: jsonObject, options: .fragmentsAllowed)
            
            request.httpBody = requestBody
        }
        catch {
            print("Error: creating data object from json object")
        }
        
        // request type
        request.httpMethod = "GET"
        
        // get URL session
        let session = URLSession.shared
        
        // create the data task
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil && data != nil{
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String : Any]
                    
                    print(dictionary)
                }
                catch {
                    print("Error: parsing response data")
                }
            }
        }
        
        dataTask.resume()
 
        */
    }
    
    
    func transitionToSignUp() {
        // transition to home screen
        let signUpViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.signUpViewController) as? SignUpViewController
        
        view.window?.rootViewController = signUpViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToLogin() {
        // transition to home screen
        let loginViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginViewController) as? LoginViewController
        
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        self.transitionToLogin()
    }
    

    @IBAction func signUpButtonTapped(_ sender: Any) {
        self.transitionToSignUp()
    }
    
}

