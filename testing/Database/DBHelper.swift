//
//  DBHelper.swift
//  testing
//
//  Created by Leon Hsieh on 3/1/21.
//

import SwiftyJSON
import Foundation
// import SQLite3


class DBHelper
{
    init()
    {
        startDatabase()
    }
    
    func startDatabase()
    {
        if let path = Bundle.main.path(forResource: "category_files/asian.txt", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                print("jsonData:\(jsonObj)")
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
    }
}

