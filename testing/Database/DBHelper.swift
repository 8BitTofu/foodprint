//
//  DBHelper.swift
//  testing
//
//  Created by Leon Hsieh on 3/1/21.
//

import Foundation
// import SQLite3


class DBHelper
{
    init()
    {
        db = startDatabase()
    }
    
    func startDatabase()
    {
        var filePath = Bundle.main.path(forResource: "allrecipes", ofType: "json")
    }
}

