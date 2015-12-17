//
//  RecipeItem.swift
//  GroceryApp
//
//  Created by Bowman on 11/18/15.
//  Copyright © 2015 Madkatz. All rights reserved.
//

import Foundation
import UIKit


class RecipeItem {
    
    var name = String()
    var image = UIImage()
    var recipeItems = [IngredientItem]()
    var category = String()
    var directions = String()
    
    
    var inShoppingList = Int(0)
    
    func setImage(image: UIImage) {
        self.image = image
    }
    
    func addItem(amount: String, item: String) {
        
        let ing = IngredientItem()
        ing.setIngredient(item, newAmount: amount)
        recipeItems.append(ing)
    }
    
    func setCategory(category: String) {
        self.category = category
    }
    
    func setName(name: String) {
        self.name = name
    }
    
    func setDirections(dir: String) {
        self.directions = dir
    }
    
    func setInShoppingList() {
        inShoppingList = 1
    }
    
    func resetInShoppingList() {
        inShoppingList = 0
    }
    
}