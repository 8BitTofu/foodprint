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
    //@IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblSteps: UILabel!
    @IBOutlet weak var txtWeight: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    
    let healthKitStore:HKHealthStore = HKHealthStore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.authorizeHealthKitApp()
        self.getLatestWeight()
        self.getLatestSteps()
        self.getLatestDistance()
        
    }
    
    
    // MARK: Buttons Actions
    
    
    @IBAction func authorizeKitClicked(_ sender: Any) {
        self.authorizeHealthKitApp()
    }
    
    @IBAction func getDetails(_ sender: Any)
    {
        self.getLatestWeight()
        self.getLatestSteps()
        self.getLatestDistance()
    }
    
    /*
    @IBAction func writeDataToHealthKit(_ sender: Any)
    {
        self.writeToKit()
        self.txtWeight.text = ""
    }
    
    func writeToKit()
    {
        let weight = Double(self.txtWeight.text!)
        
        let today = NSDate()
        if let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)
        {
            let quantity = HKQuantity(unit: HKUnit.pound(), doubleValue: Double(weight!))
            
            let sample = HKQuantitySample(type: type, quantity: quantity, start: today as Date, end: today as Date)
            healthKitStore.save(sample, withCompletion: { (success, error) in
                print("Saved \(success), error \(error)")
            })
        }
        
    }
    */
    
    func getLatestWeight()
    {
        let weightType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
        
        let query = HKSampleQuery(sampleType: weightType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, results, error) in
            if let result = results?.last as? HKQuantitySample{
                print("weight => \(result.quantity)")
                DispatchQueue.main.async(execute: { () -> Void in
                    self.txtWeight.text = "\(result.quantity)"
                });
            } else {
                print("OOPS didn't get height \nResults => \(String(describing: results)), error => \(String(describing: error))")
            }
        }
        healthKitStore.execute(query)
    }
    
    func getLatestSteps()
    {
        let stepsType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        
        let query = HKSampleQuery(sampleType: stepsType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, results, error) in
            if let result = results?.last as? HKQuantitySample{
                print("weight => \(result.quantity)")
                DispatchQueue.main.async(execute: { () -> Void in
                    self.lblSteps.text = "\(result.quantity)"
                });
            } else {
                print("OOPS didn't get height \nResults => \(String(describing: results)), error => \(String(describing: error))")
            }
        }
        healthKitStore.execute(query)
    }
    
    func getLatestDistance()
    {
        let distanceType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!
        
        let query = HKSampleQuery(sampleType: distanceType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, results, error) in
            if let result = results?.last as? HKQuantitySample{
                print("weight => \(result.quantity)")
                DispatchQueue.main.async(execute: { () -> Void in
                    self.lblDistance.text = "\(result.quantity)"
                });
            } else {
                print("OOPS didn't get height \nResults => \(String(describing: results)), error => \(String(describing: error))")
            }
        }
        healthKitStore.execute(query)
        
    }

    // MARK: Transitions
    
    /*
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
     */
    
    func authorizeHealthKitApp()
    {
        let healthKitTypesToRead: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!        ]
        
        let healthKitTypesToWrite : Set<HKSampleType> =  []
        
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
