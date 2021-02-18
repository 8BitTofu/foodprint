//
//  WelcomeViewController.swift
//  testing
//
//  Created by Austin Leung on 2/17/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidAppear(true)
        
        
        // accessing the first name and last name of current user
        let db = Firestore.firestore()
        let userID : String = (Auth.auth().currentUser?.uid)!
        let userRef = db.collection("users").document(userID)
        
        var firstName : String = ""
        var lastName : String = ""
        
        userRef.getDocument(source: .cache) { (document, error) in
            if let document = document {
                firstName = document.get("firstname") as! String
                lastName = document.get("lastname") as! String
                
                self.setWelcomeName(firstName: firstName, lastName: lastName)
            } else {
                print("Cannot access current user's firstname and lastname")
            }
        }
        

        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
            
            self.view.window?.rootViewController = homeViewController
            self.view.window?.makeKeyAndVisible()
        }

        // Do any additional setup after loading the view.
    }
    


    func setWelcomeName(firstName:String, lastName:String) -> Void {
        var welcomeText = "Welcome "
        // print("TEXT: " + String(welcomeState))
        
        if (isReturning() == true) {
            print("in returning")
            welcomeText += "back, "
        }
        
        welcomeText += firstName + " " + lastName + "!"
        welcomeLabel.text = welcomeText
    }

}
