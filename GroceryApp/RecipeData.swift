//
//  RecipeData.swift
//  GroceryApp
//
//  Created by Bowman on 11/30/15.
//  Copyright © 2015 Madkatz. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import SystemConfiguration
import Parse



private let _SingletonSharedInstance = RecipeData()


class RecipeData {
    
    private var recipeList = [RecipeItem]()
    
    class var sharedInstance: RecipeData {
        return _SingletonSharedInstance
    }
    
    func getRecipeList() -> [RecipeItem] {
        return recipeList
    }
    
    func addToParse(newItem: String) {
        let testObject = PFObject(className: "TestObject")
        
        testObject.ACL!.setPublicWriteAccess(true)
        
        testObject["foo"] = newItem
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
        }
        
    }
    
    func getGroceryListMatchingQuery(query: String) -> [RecipeItem] {
        
        var recipeSublist = [RecipeItem]()
        
        for recipe in recipeList {
            
            if query == recipe.category.lowercaseString {
                recipeSublist.append(recipe)
            }
            
            if query == recipe.name.lowercaseString {
                recipeSublist.append(recipe)
                break
            }
        }
        
        return recipeSublist
    }
    
    func addRecipes() {
        
        let gCheese = UIImage(named: "grilled_cheese")
        
        let grilledCheese = RecipeItem()
        grilledCheese.setName("Grilled Cheese")
        grilledCheese.setImage(gCheese!)
        grilledCheese.setCategory("American")
        grilledCheese.addItem("2 Slices", item: "Cheese")
        grilledCheese.addItem("2 Slices", item: "Bread")
        grilledCheese.addItem("Some", item: "Butter")
        grilledCheese.setDirections("Put the butter on one side of each slice of bread. Then place the cheese in between bread slices with the butter facing out. Grill on a hot pan until each side is golden brown.")
        
        recipeList.append(grilledCheese)
        
    }
    
    func saveRecipes() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        var error: NSError?
        do {
            try managedContext.save()
        } catch let error1 as NSError {
            error = error1
            print("Could not save \(error), \(error?.userInfo)")
        }
    }
}