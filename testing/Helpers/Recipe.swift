//
//  Recipe.swift
//  testing
//
//  Created by Leon Hsieh on 3/1/21.
//

import Foundation

class Recipe
{
    var name: String = ""
    var yields: String = ""
    var time: String = ""
    var ingredients = [String]()
    var instructions = [String]()
    var nutrients: [String: Int] = [:]
    var categories = [String]()
    var image: String = ""
    
    init(name:String, yields:String, time:String, ingredients:[String], instructions:[String], nutrients:[String:Int], categories:[String], image:String)
    {
        self.name = name
        self.yields = yields
        self.time = time
        self.ingredients = ingredients
        self.instructions = instructions
        self.nutrients = nutrients
        self.categories = categories
        self.image = image
    }
}
