//
//  RecipePageViewController.swift
//  GroceryApp
//
//  Created by Bowman on 12/1/15.
//  Copyright © 2015 Madkatz. All rights reserved.
//

import Foundation
import UIKit
import Parse

class RecipePageViewController : UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var recipeTitle: UILabel!
    
    @IBOutlet var recipeImage: UIImageView!
    
    @IBOutlet var recipeDirections: UITextView!
    
    var shoppingList = [String]()
    
    var recipeItem = RecipeItem()
    
    var i : CGFloat = 320
    
    override func viewDidLoad() {
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "login_flat")!)
        //scrollView.contentSize.height = 1000
        recipeImage.image = recipeItem.image
        recipeTitle.text = recipeItem.name
        
        addIngredients()
        
        i += 10
        
        let label = UILabel(frame: CGRectMake(0, 0, 200, 50))
        label.textAlignment = .Left
        label.font = UIFont(name: "Copperplate-Bold", size: 17.0)
        label.center = CGPointMake(110, i)
        label.text = "Directions:"
        //label.font =
        scrollView.addSubview(label)
        
        i += 90
        
        //recipeDirections.font = UIFont(name: "Copperplate", size: 17)
        recipeDirections.center = CGPointMake(160, i)
        recipeDirections.text = recipeItem.directions
        
        scrollView.contentSize.height = i + recipeDirections.frame.height
        
    }
    
    /*@IBAction func addToShoopingList(sender: AnyObject) {
        for ing in recipeItem.recipeItems {
            addToParse(ing.item)
        }
    }*/
    
    @IBAction func addToShoopingList(Sender: AnyObject) {
        let alert = UIAlertController(title: recipeItem.name, message: "All Ingredents Have Been Added to Shopping List.", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Close", style: .Cancel, handler: {
            action in
            
            for ing in self.recipeItem.recipeItems {
                self.addToParse(ing.item)
            }
            
        })
        
        alert.addAction(cancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func addToParse(newItem: String) {
        let testObject = PFObject(className: "TestObject")
        
        testObject.ACL!.setPublicWriteAccess(true)
        
        testObject["foo"] = newItem
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
        }
        
    }
    
    func addIngredients() {
        
        for ingredient in recipeItem.recipeItems {
            
            let label = UILabel(frame: CGRectMake(0, 0, 200, 50))
            label.textAlignment = .Left
            label.center = CGPointMake(110, i)
            label.font = UIFont(name: "Helvetica", size: 17)
            label.text = ingredient.amount.stringByPaddingToLength(12, withString: " ", startingAtIndex: 0)
                + " " + ingredient.item
            
            i += 20
            
            scrollView.addSubview(label)
        }
        //self.view.addSubview(label)
        
    }
    
}