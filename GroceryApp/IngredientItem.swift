//
//  IngredientItem.swift
//  GroceryApp
//
//  Created by Bowman on 11/30/15.
//  Copyright © 2015 Madkatz. All rights reserved.
//

import Foundation
import UIKit

class IngredientItem {
    
    var item = String()
    var amount = String()
    
    func setIngredient(newItem: String, newAmount: String) {
        item = newItem
        amount = newAmount
    }
}