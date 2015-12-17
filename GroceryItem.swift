//
//  GroceryItem.swift
//  GroceryApp
//
//

import Foundation
import UIKit


class GroceryItem {
    
    var name = String()
    var category = String()
    var inShoppingList = Int(0)
    var image = UIImage()
    var price = Float()
    
    func setImage(image: UIImage) {
        self.image = image
    }
    
    func setName(name: String) {
        self.name = name
    }
    
    func setPrice(price: Float) {
        self.price = price
    }
    
    func setCategory(category: String) {
        self.category = category
    }
    
    func setInShoppingList() {
        inShoppingList = 1
    }
    
    func resetInShoppingList() {
        inShoppingList = 0
    }
    
}
