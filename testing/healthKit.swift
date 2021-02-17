//
//  healthKit.swift
//  testing
//
//  Created by Austin Leung on 2/14/21.
//  Inspired from / used some code from "https://www.spaceotechnologies.com/integrate-healthkit-data-develop-fitness-apps-iphone/"

import Foundation
import HealthKit

class HealthKitAssistant {
    //Shared Variable
    static let shared = HealthKitAssistant()
    
    //Healthkit store object
    let healthKitStore = HKHealthStore()

    //MARK: Permission block
    func getHealthKitPermission(completion: @escaping (Bool) -> Void) {
            
        //Check HealthKit Available
        guard HKHealthStore.isHealthDataAvailable() else {
            return
        }
            
        let stepsCount = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
            
        self.healthKitStore.requestAuthorization(toShare: [stepsCount], read: [stepsCount]) { (success, error) in
            if success {
                completion(true)
            } else {
                if error != nil {
                    print(error ?? "")
                }
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
    
    //MARK: - Get Recent step Data
    func getMostRecentStep(for sampleType: HKQuantityType, completion: @escaping (_ stepRetrieved: Int, _ stepAll : [[String : String]]) -> Void) {
        
        // Use HKQuery to load the most recent samples.
        let mostRecentPredicate =  HKQuery.predicateForSamples(withStart: Date.distantPast, end: Date(), options: .strictStartDate)
        
        var interval = DateComponents()
        interval.day = 1
        
        let stepQuery = HKStatisticsCollectionQuery(quantityType: sampleType , quantitySamplePredicate: mostRecentPredicate, options: .cumulativeSum, anchorDate: Date.distantPast, intervalComponents: interval)
        
        stepQuery.initialResultsHandler = { query, results, error in
            
            if error != nil {
                //  Something went Wrong
                return
            }
            if let myResults = results {
                
                var stepsData : [[String:String]] = [[:]]
                var steps : Int = Int()
                stepsData.removeAll()
                
                myResults.enumerateStatistics(from: Date.distantPast, to: Date()) {
                    
                    statistics, stop in
                    
                    //Take Local Variable
                    
                    if let quantity = statistics.sumQuantity() {
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MMM d, yyyy"
                        dateFormatter.locale =  NSLocale(localeIdentifier: "en_US_POSIX") as Locale?
                        dateFormatter.timeZone = NSTimeZone.local
                        
                        var tempDic : [String : String]?
                        let endDate : Date = statistics.endDate
                        
                        steps = Int(quantity.doubleValue(for: HKUnit.count()))
                        
                        print("DataStore Steps = \(steps)")
                        
                        tempDic = [
                            "enddate" : "\(dateFormatter.string(from: endDate))",
                            "steps"   : "\(steps)"
                        ]
                        stepsData.append(tempDic!)
                    }
                }
                completion(steps, stepsData.reversed())
            }
        }
        HKHealthStore().execute(stepQuery)
    }
    
}
