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
    
    @IBOutlet weak var logoLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidAppear(true)
        
        // change background color
        self.view.backgroundColor = .white
        
        logoLabel.textColor = Constants.appColors.orangeRed
        
        
        // accessing the first name and last name of current user
        let db = Firestore.firestore()
        let userID : String = getCurrentUserID()
        let userRef = db.collection("users").document(userID)
        
        var firstName : String = ""
        var lastName : String = ""
        
        // set the welcome text to personalized name
        userRef.getDocument(source: .cache) { (document, error) in
            if let document = document {
                firstName = document.get("firstname") as! String
                lastName = document.get("lastname") as! String
                
                self.setWelcomeName(firstName: firstName, lastName: lastName)
            } else {
                print("Cannot access current user's firstname and lastname")
            }
        }
        

        
        // after some time change from splash screen to home screen
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let tabbedViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabbedViewController) as? TabbedViewController
            
            self.view.window?.rootViewController = tabbedViewController
            self.view.window?.makeKeyAndVisible()
        }

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: Setup

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
