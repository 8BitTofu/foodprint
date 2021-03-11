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
    var file_pointers = [String: Int]()
        
    init()
    {
        file_pointers = retrieve_fps()
    }
    
    func retrieve_fps() -> Dictionary<String, Int>
    {
        var post = [String: Int]()
        if let path = Bundle.main.path(forResource: "fp", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                for (key, value) in  jsonObj
                {
                    post[key] = value.intValue
                }
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
        return post
    }
    
    func startDatabase()
    {
        let pathURL = URL(fileURLWithPath: "allrecipes.json")
        if FileManager.default.fileExists(atPath: pathURL.path) { print(1) }

        let s = dbReader(url: pathURL)
    }
}

