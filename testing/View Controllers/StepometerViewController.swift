//
//  StepometerViewControl.swift
//  testing
//
//  Created by Daniel Mishkanian on 3/3/21.
//

import Foundation
import CoreMotion
import UIKit


class StepometerViewController: UIViewController {
    
    
    @IBOutlet weak var lbCounter: UILabel!
    
    @IBOutlet weak var homeButton: UIButton!

    let activityManager = CMMotionActivityManager()
    let pedometer = CMPedometer()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        
        makeSolidButton(button: homeButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
        
        
        if CMPedometer.isStepCountingAvailable() {
            self.pedometer.startUpdates(from: Date()) { (data, error) in
                if error == nil {
                    if let response = data {
                        DispatchQueue.main.sync {
                            print("Number of steps = \(response.numberOfSteps)")
                            self.lbCounter.text = "Step Counter: \(response.numberOfSteps)"
                        }
                    }
                }
            }
        }
    }
        
    func transitionToHome() {
        // transition to home screen
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func stepButtonTapped(_ sender: Any) {
        self.transitionToHome()
    }
        
    
    
}


