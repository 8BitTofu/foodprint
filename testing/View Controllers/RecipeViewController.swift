//
//  RecipeViewController.swift
//  testing
//
//  Created by Austin Leung on 3/10/21.
//

import UIKit

class RecipeViewController: UIViewController {

    // MARK: Buttons / Labels
    
    @IBOutlet weak var backButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backButton.tintColor = Constants.appColors.mustard
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
