import SwiftyJSON
import Foundation
// import SQLite3


class DBHelper
{
    var file_pointers = [String: Int]()
    var db: dbReader
        
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
                for (key, value) in value1
                {
                    if key == "yield"{
                        recipe.yields = value.string!
                    }
                    else if key == "image"{
                        recipe.image = value.string!
                    }
                    else if key == "time"{
                        recipe.time = value.string!
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
                            recipe.categories.append(category.1.string!)
                        }
                    }
                    else if key == "nutrients"{
                        for (nutrient_name, nutrient_value) in value{
                            recipe.nutrients[nutrient_name] = nutrient_value.string
                        }
                    }
                }
            }
        }catch _{
            print("error")
        }
        return recipe
    }
}
