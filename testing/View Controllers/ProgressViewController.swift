//
//  ProgressViewController.swift
//  testing
//
//  Created by Austin Leung on 3/9/21.
//

import UIKit

class ProgressViewController: UIViewController {

    // MARK: Buttons / Labels
    
    @IBOutlet weak var stepometerButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    // MARK: Buttons Actions
    
    @IBAction func stepometerTapped(_ sender: Any) {
        transitionToStepometerView()
    }
    
    
    
    

    // MARK: Transitions
    
    func transitionToStepometerView() {
        // transition to account screen
        let stepometerViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.stepometerViewController) as? StepometerViewController
        
        view.window?.rootViewController = stepometerViewController
        view.window?.makeKeyAndVisible()
    }

}
