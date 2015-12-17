//
//  GroceryData.swift
//  GroceryApp
//
//

import Foundation
import UIKit
import CoreData
import SystemConfiguration
import Parse



private let _SingletonSharedInstance = GroceryData()


class GroceryData {
    
    class var sharedInstance: GroceryData {
        return _SingletonSharedInstance
    }

    private var groceryList = [GroceryItem]()
    private var couponList = [CouponItem]()
    
    func getGroceryList() -> [GroceryItem] {
        return groceryList
    }
    
    func getCouponList() -> [CouponItem] {
        return couponList
    }
    
    
    //may need to change something here.........
    func addToShoppingList(newItem: GroceryItem) {
        newItem.setInShoppingList()
        //shoppingList.append(newItem)
        addToParse(newItem.name)
    }
    
    func addToParse(newItem: String) {
        let testObject = PFObject(className: "TestObject")
        
        testObject.ACL!.setPublicWriteAccess(true)
        
        testObject["foo"] = newItem
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
        }
        
    }
    
    func retrieveFromParse() {
        
        let query = PFQuery(className:"TestObject")
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                if let objects = objects as? [PFObject] {
                    
                    
                    for listItem in objects {
                        
                        let newItem:String = (listItem as PFObject)["foo"] as! String
                        
                        if self.inGroceryList(newItem) {
                            self.addFromGroceryListToShoppingList(newItem)
                        }
                    }
                    
                }
            
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    func inShoppingList(itemName: String) -> Bool{
        
        for item in groceryList {
            
            if item.name.lowercaseString == itemName.lowercaseString {
                
                if item.inShoppingList == 1 {
                    return true
                }
            }
            
        }
        return false
    }
    
    //Used to find groceries in grocery list that have been saved through parse, but not yet added to shopping list
    func inGroceryList(itemName: String) -> Bool {
        
        for grocery in groceryList {
            if grocery.name.lowercaseString == itemName.lowercaseString {
                return true
            }
        }
        
        return false
    }
    
    //used to add items that were saved in Parse, to the shopping list
    func addFromGroceryListToShoppingList(itemName: String) {
        
        for grocery in groceryList {
            
            if grocery.name.lowercaseString == itemName.lowercaseString {
                grocery.setInShoppingList()
                break
            }
            
        }
    }
    
    func unsetItemInGroceryList(itemName: String) {
        
        for grocery in groceryList {
            
            if itemName.lowercaseString == grocery.name.lowercaseString {
                grocery.resetInShoppingList()
            }
            
        }
        
    }
    
    func getGroceryListMatchingQuery(query: String) -> [GroceryItem] {
        
        var grocerySublist = [GroceryItem]()
        
        for grocery in groceryList {
            
            if query == grocery.category.lowercaseString {
                grocerySublist.append(grocery)
            }
            
            if query == grocery.name.lowercaseString {
                grocerySublist.append(grocery)
                break
            }
        }
        
        return grocerySublist
    }
    
    func deleteFromShoppingList(itemToRemove: String) {
        
        //var curGrocery : String
        
        //var i = 0
        /*for grocery in shoppingList {
            
            if grocery.name == itemToRemove {
                grocery.resetInShoppingList()
                shoppingList.removeAtIndex(i)
                break
            }
            i++
        }*/
        
        for grocery in groceryList {
            
            if grocery.name == itemToRemove {
                grocery.resetInShoppingList()
                break
            }
            
        }
    }
    
    /*func removeFromShoppingList(itemToRemove: String) -> [GroceryItem] {
        
        var curGrocery : String
        
        var i = 0
        for grocery in shoppingList {
            
            if grocery.name == itemToRemove {
                grocery.resetInShoppingList()
                shoppingList.removeAtIndex(i)
            }
            
            i++
        }
        
        return shoppingList
    }*/
    
    
    
    /*func printShoppingList() {
        
        var curGrocery : String
        
        for grocery in shoppingList {
            curGrocery = grocery.name
            println(curGrocery)
        }
    }*/
    
    func addCouponItems() {
        
        let chipsAhoyPic = UIImage(named: "chipsAhoy")
        let cakePic = UIImage(named: "cake")
        let barcodePic = UIImage(named: "barcode")
        
        let chipsAhoyCoupon = CouponItem()
        chipsAhoyCoupon.setName("Chips Ahoy Cookies")
        chipsAhoyCoupon.setCategory("Snack Food")
        chipsAhoyCoupon.setDealString("Buy One Get One FREE")
        chipsAhoyCoupon.setBarcodeImage(barcodePic!)
        chipsAhoyCoupon.setImage(chipsAhoyPic!)
        
        let cakeCoupon = CouponItem()
        cakeCoupon.setName("Cake")
        cakeCoupon.setCategory("Bakery")
        cakeCoupon.setDealString("$5.00 OFF")
        cakeCoupon.setBarcodeImage(barcodePic!)
        cakeCoupon.setImage(cakePic!)
        
        couponList.append(chipsAhoyCoupon)
        couponList.append(cakeCoupon)
        
    }
    
    func addGroceryItems() {
        
        //loading food images from asset catalog
        let iceCreamPic = UIImage(named: "ice_cream")
        let beerPic = UIImage(named: "beer")
        let cerealPic = UIImage(named: "cereal")
        let broccoliPic = UIImage(named: "broccoli")
        let baconPic = UIImage(named: "bacon")
        let applesPic = UIImage(named: "apples")
        let orangesPic = UIImage(named: "oranges")
        let milkPic = UIImage(named: "milk")
        let sodaPic = UIImage(named: "soda")
        let lettucePic = UIImage(named: "lettuce")
        let pizzaPic = UIImage(named: "pizza")
        let eggsPic = UIImage(named: "eggs")
        let tvdinnerPic = UIImage(named: "tvdinner")
        let coffeePic = UIImage(named: "coffee")
        let breadPic = UIImage(named: "bread")
        let juicePic = UIImage(named: "juice")
        
        
        let bread = GroceryItem()
        bread.setName("Wonder Bread")
        bread.setCategory("Breakfast")
        bread.setImage(breadPic!)
        bread.setPrice(2.39)
        groceryList.append(bread)
        
        let juice = GroceryItem()
        juice.setName("Juicy Juice")
        juice.setCategory("Beverages")
        juice.setImage(juicePic!)
        juice.setPrice(3.79)
        groceryList.append(juice)
        
        let eggs = GroceryItem()
        eggs.setName("Eggs")
        eggs.setCategory("Dairy")
        eggs.setImage(eggsPic!)
        eggs.setPrice(2.49)
        groceryList.append(eggs)
        
        let pizza = GroceryItem()
        pizza.setName("Digiorno Pizza")
        pizza.setCategory("Frozen")
        pizza.setImage(pizzaPic!)
        pizza.setPrice(7.99)
        groceryList.append(pizza)
        
        let tvdinner = GroceryItem()
        tvdinner.setName("Hungry-Man Dinner")
        tvdinner.setCategory("Frozen")
        tvdinner.setImage(tvdinnerPic!)
        tvdinner.setPrice(4.79)
        groceryList.append(tvdinner)
        
        let coffee = GroceryItem()
        coffee.setName("Starbucks Coffee")
        coffee.setCategory("Breakfast")
        coffee.setImage(coffeePic!)
        coffee.setPrice(6.99)
        groceryList.append(coffee)
        
        let iceCream = GroceryItem()
        iceCream.setName("Scotchy...Ice Cream")
        iceCream.setCategory("Frozen")
        iceCream.setImage(iceCreamPic!)
        iceCream.setPrice(3.75)
        groceryList.append(iceCream)
        
        let beer = GroceryItem()
        beer.setName("Heineken Beer")
        beer.setCategory("Beverages")
        beer.setImage(beerPic!)
        beer.setPrice(13.75)
        groceryList.append(beer)
        
        let cereal = GroceryItem()
        cereal.setName("Pops Cereal")
        cereal.setCategory("Breakfast")
        cereal.setImage(cerealPic!)
        cereal.setPrice(4.95)
        groceryList.append(cereal)
        
        let broccoli = GroceryItem()
        broccoli.setName("Broccoli")
        broccoli.setCategory("Produce")
        broccoli.setImage(broccoliPic!)
        broccoli.setPrice(1.35)
        groceryList.append(broccoli)
        
        let bacon = GroceryItem()
        bacon.setName("Oscar Meyer Bacon")
        bacon.setCategory("Deli")
        bacon.setImage(baconPic!)
        bacon.setPrice(5.60)
        groceryList.append(bacon)
        
        let apples = GroceryItem()
        apples.setName("Apples")
        apples.setCategory("Produce")
        apples.setImage(applesPic!)
        apples.setPrice(2.05)
        groceryList.append(apples)
        
        let oranges = GroceryItem()
        oranges.setName("Oranges")
        oranges.setCategory("Produce")
        oranges.setImage(orangesPic!)
        oranges.setPrice(2.35)
        groceryList.append(oranges)
        
        let milk = GroceryItem()
        milk.setName("Milk")
        milk.setCategory("Dairy")
        milk.setImage(milkPic!)
        milk.setPrice(2.95)
        groceryList.append(milk)
        
        let soda = GroceryItem()
        soda.setName("Soda")
        soda.setCategory("Beverages")
        soda.setImage(sodaPic!)
        soda.setPrice(4.25)
        groceryList.append(soda)
        
        let lettuce = GroceryItem()
        lettuce.setName("Lettuce")
        lettuce.setCategory("Produce")
        lettuce.setImage(lettucePic!)
        lettuce.setPrice(1.15)
        groceryList.append(lettuce)
        
    }
    
    func saveGroceries() {
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