//
//  CategoryInfo.swift
//  testing
//
//  Created by Austin Leung on 3/2/21.


//  This file contains all the category information.
//  Categories in this sense are what the user will select as food PREFERENCES
//  These categories are then used to help filter through the database
//  CATEGORY_NAME = [EXACT_STRING_NAMES_FROM_JSON, ...]

//  each of these exact string names will be considered one of the CATEGORY_NAME
//  CATEGORY_NAME will be a broad term for all the list items (i.e. vegetables)

//  I stopped adding categories at around the ~50 count mark.

//  source file: Database/categories.txt



import Foundation


class foodCategories {
    
    
    // MARK: Assorted Categories

    let sweets = ["Dessert Recipes", "Specialty Dessert Recipes"]

    let seafood = ["Seafood", "Fish", "Seafood Main Dish Recipes", "Shellfish", "Seafood Salad Recipes", "Shrimp", "Salmon"]

    let nuts = ["Nuts and Seeds", "Peanut Butter"]

    let fruits = ["Fruits and Vegetables", "Cranberry", "Fruit Dip", "Raspberry Dessert Recipes", "Cherry Crisps and Crumbles Recipes", "Coconut", "Fruit", "Apple Cobbler Recipes", "Fruit Pie Recipes"]

    let soups = ["Soup Recipes", "Vegetable Soup Recipes", "Stews"]

    let baked = ["Pies", "Muffin Recipes", "Scone Recipes", "Cobbler Recipes", "Bar Cookie Recipes", "Potato Casserole", "Zucchini Bread Recipes", "Pot Pie Recipes", "Snickerdoodle Recipes", "Cherry Crisps and Crumbles Recipes", "Cookies", "Rhubarb Crisps and Crumbles Recipes", "Gingersnap Recipes", "Sweet Potato Casserole Recipes", "Coffee Cake", "Crumb Crusts", "Corn Muffin Recipes", "Pumpkin Muffin Recipes", "Spinach Casserole", "Lasagna Recipes", "Apple Cobbler Recipes", "Spice Cake Recipes", "Fruit Pie Recipes", "Chicken Pie Recipes", "Upside-Down Cake Recipes", "Cake Mix Cake Recipes"]

    // let cheese = ["Cheese", "Grilled Cheese"]

    // let roasted = ["Roasted"]

    let vegetables = ["Vegetables", "Vegetable", "Vegetable Soup Recipes", "Squash", "Fruits and Vegetables", "Potato Side Dish Recipes", "Beans and Peas", "Cauliflower"]

    let salads = ["Salad", "Seafood Salad Recipes", "Green Salad Recipes"]

    let meats = ["Beef","Meat and Poultry", "Turkey", "Steaks", "Chicken", "Chicken Breast Recipes", "Pork", "Pork Chop Recipes", "Ham"]

    let pastas = ["Pasta", "Pasta Salad Recipes", "Tetrazzini Recipes", "Pasta Appetizer Recipes", "Ravioli Recipes"]

    let bread = ["Bread", "Quick Bread Recipes", "Yeast Bread Recipes"]

    let healthy = ["Healthy", "Quinoa Salad Recipes"]

    // let pork = ["Pork", "Pork Chop Recipes"]

    // let beef = ["Beef", "Steaks"]

    // let chicken = ["Chicken", "Chicken Breast Recipes"]

    // let dips = ["Dips and Spreads Recipes"]

    // let eggs = ["Eggs"]

    // let pies = ["Pies"]

    // let sandwich = ["Sandwich Recipes"]

    // let wrapsRolls = ["Wraps and Rolls"]





    // MARK: Cuisine Types

    // let austrian = ["Austrian"]

    let asian = ["Asian", "Chinese", "Thai", "Filipino", "Japanese", "Korean"]

    // let irish = ["Irish"]

    let caribbean = ["Caribbean"]

    let european = ["UK and Ireland", "European", "greek", "austrian", "french", "italian", "polish", "german", "spanish", "irish"]

    let mexican = ["Mexican"]

    // let greek = ["Greek"]

    // let french = ["French"]

    // let italian = ["Italian"]

    // let polish = ["Polish"]

    let persian = ["Persian"]

    let indian = ["Indian"]

    let latin = ["Latin American"]

    // let german = ["German"]
    
    // let spanish = ["Spanish"]




    // MARK: Meal Type

    let breakfast = ["Breakfast and Brunch", "Pancake Recipes"]

    let lunch = ["Main Dish Recipes", "Breakfast and Brunch", "Stuffed Main Dish Recipes"]

    let dinner = ["Main Dish Recipes", "Stuffed Main Dish Recipes"]

    let dessert = ["Fruit Dessert Recipes", "Cakes"]

    let snacks = ["Side Dish", "Appetizers and Snacks", "Snacks"]

    let drinks = ["Drinks Recipes", "Cocktail Recipes", "Drinks"]




    // MARK: Restrictions

    let vegetarian = "Vegetarian"
}
