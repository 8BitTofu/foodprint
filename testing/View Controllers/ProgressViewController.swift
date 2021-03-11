//
//  ProgressViewController.swift
//  testing
//
//  Created by Austin Leung on 3/9/21.
//

import UIKit
import HealthKit

class ProgressViewController: UIViewController {

    // MARK: Buttons / Labels
    
    @IBOutlet weak var stepometerButton: UIButton!
    @IBOutlet weak var lblAge: UILabel!
    
    
    let healthKitStore:HKHealthStore = HKHealthStore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    // MARK: Buttons Actions
    
    @IBAction func stepometerTapped(_ sender: Any) {
        transitionToStepometerView()
    }
    
    
    @IBAction func authorizeKitClicked(_ sender: Any) {
        self.authorizeHealthKitApp()
    }
    
    @IBAction func getDetails(_ sender: Any)
    {
        let age = self.readProfile()
        self.lblAge.text = "\(String(describing: age))"
    }

    // MARK: Transitions
    
    func transitionToStepometerView(){
        // transition to account screen
        let stepometerViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.stepometerViewController) as? StepometerViewController
        
        view.window?.rootViewController = stepometerViewController
        view.window?.makeKeyAndVisible()
    }
    
    func readProfile() -> Int?
    {
        var age:Int?
        
        do {
            let birthDay = try healthKitStore.dateOfBirthComponents()
            let calendar = Calendar.current
            let currentyear = calendar.component(.year, from: Date())
            age = currentyear - birthDay.year!
            
        } catch {}
        

        return age
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
