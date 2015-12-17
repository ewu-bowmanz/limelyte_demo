//
//  GroceryItemCell.swift
//  GroceryApp
//
//

import Foundation
import UIKit
import CoreData
import Parse

class GroceryItemCell : UICollectionViewCell {
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var plusButtonDisplayed = true
    var groceryItem : GroceryItem!
    let minusImage = UIImage(named: "minus")
    let plusImage = UIImage(named: "plus")
    
    @IBAction func addButtonPressed(sender: AnyObject) {
        
        let groceryData = GroceryData.sharedInstance
        
        if plusButtonDisplayed {
            groceryData.addToShoppingList(groceryItem)
        } else {
            groceryData.deleteFromShoppingList(groceryItem.name)
            deleteItemFromParse(groceryItem.name)
        }
        
        groceryData.saveGroceries()
        switchButtons()
    }
    
    func deleteItemFromParse(food : String) {
        
        let query = PFQuery(className:"TestObject")
        
        query.whereKey("foo", equalTo: food)
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                if let objects = objects as? [PFObject] {
                    
                    for listItem in objects {
                        listItem.deleteInBackground()
                    }
                    
                }
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    func setMinusButton() {
        addButton.setImage(minusImage, forState: UIControlState.Normal)
        plusButtonDisplayed = false
    }
    
    func setPlusButton() {
        addButton.setImage(plusImage, forState: UIControlState.Normal)
        plusButtonDisplayed = true
    }
    
    
    func switchButtons() {
        
        if (plusButtonDisplayed) {
            setMinusButton()
        } else {
            setPlusButton()
        }
        
        self.superview?.setNeedsDisplay()
    }
    
}
