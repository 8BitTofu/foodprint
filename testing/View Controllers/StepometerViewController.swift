//
//  StepometerViewControl.swift
//  testing
//
//  Created by Daniel Mishkanian on 3/3/21.
//

import Foundation
import CoreMotion
import UIKit
import HealthKit


class StepometerViewController: UIViewController{
    
    
    @IBOutlet weak var lbCounter: UILabel!
    
    @IBOutlet weak var homeButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    
    
    
    

    let activityManager = CMMotionActivityManager()
    let pedometer = CMPedometer()
    
    let healthKitStore:HKHealthStore = HKHealthStore()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        print("INSIDE PEDOMETER")
        
        //makeSolidButton(button: homeButton, backgroundColor: Constants.appColors.orangeRed, textColor: .white)
        
        
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
        let tabbedViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabbedViewController) as? TabbedViewController
        
        view.window?.rootViewController = tabbedViewController
        view.window?.makeKeyAndVisible()
    }
    

    
    @IBAction func stepButtonTapped(_ sender: Any) {
        self.transitionToHome()
    }
        
    @IBAction func backTapped(_ sender: Any) {
        transitionToHome()
    }
    
    @IBAction func authorizeKitClicked(_ sender: Any) {
        self.authorizeHealthKitApp()
    }
    
    func getHealthInfo()
    {
        
    }
    
    func authorizeHealthKitApp()
    {
        let healthKitTypesToRead: Set<HKObjectType> = [
            HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.dateOfBirth)!,
            HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.bloodType)!,
            //HKObjectType.quantityType(forIdentifier: .bodyMass)!,
        ]
        
        let healthKitTypesToWrite : Set<HKSampleType> = []
        
        if !HKHealthStore.isHealthDataAvailable()
        {
            print("Error occured")
            return
        }
        
        healthKitStore.requestAuthorization(toShare: healthKitTypesToWrite, read: healthKitTypesToRead)
        { (success, error) -> Void in
            print("Read Write Authorization succeeded")
        }
    }
    
    
}


