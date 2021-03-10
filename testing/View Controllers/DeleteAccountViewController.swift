//
//  DeleteAccountViewController.swift
//  testing
//
//  Created by Austin Leung on 3/5/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore



class DeleteAccountViewController: UIViewController {

    // MARK: Buttons / Labels
    
    @IBOutlet var logoLabel: UILabel!
    
    @IBOutlet var promptLabel: UILabel!
    
    @IBOutlet var keepButton: UIButton!
    
    @IBOutlet var deleteButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: UI / Aesthetics
        
        logoLabel.textColor = Constants.appColors.orangeRed
        promptLabel.textColor = Constants.appColors.orangeRed
        deleteButton.setTitleColor(Constants.appColors.orangeRed, for: .normal)
        
        makeSolidButton(button: keepButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)

    }
    
    
    
    // MARK: Buttons

    @IBAction func keepButtonTapped(_ sender: Any) {
        transitionToAccount()
    }
    
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        // when clicking delete button - delete all previous progress
        // on making a user account
        
        // get current user data
        let db = Firestore.firestore()
        let userID : String = (Auth.auth().currentUser?.uid)!
        
        // delete user document from users collection on Firebase
        db.collection("users").document(userID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        
        // delete user account from authentification side
        Auth.auth().currentUser?.delete(completion: { err in
            if let err = err {
                print("Error removing user: \(err)")
            } else {
                print("User successfully removed!")
            }
        })
        
        self.transitionToBase()
    }
    
    
    // MARK: Transitions
    
    func transitionToBase() {
        // transition to home screen
        let baseViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.baseViewController) as? ViewController
        
        view.window?.rootViewController = baseViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    func transitionToAccount() {
        // transition to home screen
        let accountViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.accountViewController) as? AccountViewController
        
        view.window?.rootViewController = accountViewController
        view.window?.makeKeyAndVisible()
    }

}
