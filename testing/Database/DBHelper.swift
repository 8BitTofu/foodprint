import SwiftyJSON
import Foundation
import Firebase
// import SQLite3


class DBHelper
{
    var file_pointers = [String: Int]()
    var db: dbReader
    var random_pref: [Int:String]
    
    init()
    {
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
        
        
        self.file_pointers = retrieve_fps() // initialize fp s
        
        let pathname = Bundle.main.path(forResource: "allrecipes", ofType: "json")
        self.db = dbReader(path: pathname!)! //initialize db
        self.random_pref = [1:"asian", 2:"baked", 3:"caribbean", 4:"european", 5:"healthy", 6:"indian", 7: "latin", 8: "meats", 9: "mexican", 10: "nuts", 11: "pastas", 12: "persian", 13: "salads", 14: "seafood", 15: "soups", 16: "vegetables"]
    }
    
    func print_recipe(recipe: Recipe)
    {
        print("name: \(recipe.name)")
        print("yields: \(recipe.yields)")
        print("time: \(recipe.time)")
        print("instructions: \(recipe.instructions)")
        print("ingredients: \(recipe.ingredients)")
        print("nutrients: \(recipe.nutrients)")
        print("image: \(recipe.image)")
        print("categories: \(recipe.categories)")
    }
    
    func retrieve_preferences(pref: String) -> Dictionary<Double, String>
    {
        var post = [Double: String]()
        if let path = Bundle.main.path(forResource: "categories/" + pref, ofType: "txt") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                for (key, value) in  jsonObj
                {
                    for (_, v) in value{
                        post[Double(key)!] = v.string
                    }
                }
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
        return post
    }
    
    // Enter a recipe name and this will return a Recipe object.. crazy huh
    func retrieve_recipe(name: String) -> Recipe?
    {
        db.seek(fp: UInt64(file_pointers[name]!))
        let jsonString = db.nextLine()
        let recipe = Recipe()
        do{
            let dataFromString = try jsonString!.data(using: .utf8, allowLossyConversion: false)
            let json = try JSON(data: dataFromString!)
            for (key1, value1) in json
            {
                recipe.name = key1
                // print("recipe.name: " + key1)
                for (key, value) in value1
                {
                    if key == "yield"{
                        recipe.yields = value.string!
                    }
                    else if key == "image"{
                        recipe.image = value.string!
                    }
                    else if key == "time"{
                        recipe.time = value.string ?? "" // temporary fix
                    }
                    else if key == "ingredients"{
                        for ingredient in value{
                            recipe.ingredients.append(ingredient.1.string!)
                        }
                    }
                    else if key == "instructions"{
                        for instruction in value{
                            recipe.instructions.append(instruction.1.string!)
                        }
                    }
                    else if key == "category"{
                        for category in value{
                            recipe.categories.insert(category.1.string!)
                        }
                    }
                    else if key == "nutrients"{
                        for (nutrient_name, nutrient_value) in value{
                            recipe.nutrients[nutrient_name] = nutrient_value.string
                            // print("nutName: " + nutrient_name)
                            // print(nutrient_value)
                        }
                    }
                }
            }
        }catch let error{
            print("recipe retrieval error: \(error)")
            print(jsonString as Any)
        }
        return recipe
    }
    
    func ranking(n: Int = 100, calories: Double = 0.0) -> Void
    {
        let preference_value = 20.0
        let max_calorie_value = 75.0
        let max_error = 0.3
        
        let rank_constant = 1.0 // for ever 1 % error in calories, the ranking score is deducted by this value
        
        var preferences = [String]()
        var added_preferences = [String]()
        
        let db = Firestore.firestore()
        let userID : String = (Auth.auth().currentUser?.uid)!
        let userRef = db.collection("users").document(userID)
        var ranked_meals = [String:Double]()
        var list = [String]()
        var used = Set<Int>()
        
        userRef.getDocument(source: .cache) { [self] (document, error) in
            if let document = document {
                preferences = document.get("preferences") as! [String]
                // case when there are too little pref
                if preferences.count < 5{
                    var i = preferences.count
                    while i < 5
                    {
                        let randomInt = Int.random(in: 1..<self.random_pref.count)
                        if used.contains(randomInt){
                            continue
                        }
                        used.insert(randomInt)
                        added_preferences.append(self.random_pref[randomInt]!)
                        i+=1
                    }
                }
                // print("preferences: \(preferences)")
                // print("added preferences: \(added_preferences)")
                
                var temp = [Double:String]()
                
                for preference in added_preferences{
                    self.retrieve_preferences(pref: preference).forEach({(key, value) in temp[key] = value})
                }
                for (k, v) in temp{
                    if k < calories*(1.0 - max_error) || k > calories*(1.0 + max_error){
                        continue
                    }
                    let deductions = rank_constant*(abs(k-calories)/calories/0.01)
                    ranked_meals[v] = max_calorie_value - deductions
                }
                
                temp.removeAll()
                for preference in preferences{
                    retrieve_preferences(pref: preference).forEach({(key, value) in temp[key] = value})
                }
                for (k, v) in temp{
                    if k < calories*(1.0 - max_error) || k > calories*(1.0 + max_error){
                        continue
                    }
                    let deductions = rank_constant*(abs(k-calories)/calories/0.01)
                    ranked_meals[v] = preference_value + max_calorie_value - deductions
                }
                
                temp.removeAll()
                while (ranked_meals.count) < n{
                    let randomInt = Int.random(in: 1..<self.random_pref.count)
                    if used.contains(randomInt){
                        continue
                    }
                    used.insert(randomInt)
                    temp = retrieve_preferences(pref: self.random_pref[randomInt]!)
                    for (k,v) in temp{
                        if ranked_meals[v] == nil{
                            continue
                        }
                        if k < calories*(1.0 - max_error) || k > calories*(1.0 + max_error){
                            continue
                        }
                        let deductions = rank_constant*(abs(k-calories)/calories/0.01)
                        ranked_meals[v] = max_calorie_value - deductions
                    }
                }
                
                let sortedByValueDictionary = ranked_meals.sorted { $0.1 > $1.1 }
                var i = 0
                for (k, v) in sortedByValueDictionary{
                    if(i == n){
                        break
                    }
                    list.append(k)
                    i+=1
                }
                
                // print(list)
                
                
                userRef.updateData([
                                    "currentRecipes": list
                ]) { err in
                    if err != nil {
                        print("Error updating currentRecipes")
                    } else {
                        print("currentRecipes successfully updated")
                    }
                }
                
                
            } else {
                print("Cannot access current user's preferences")
            }
        }
    }
}
