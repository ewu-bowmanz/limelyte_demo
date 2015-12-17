//
//  ShoppingListController.swift
//  GroceryApp
//
//  Created by Bowman on 10/28/15.
//  Copyright © 2015 Madkatz. All rights reserved.
//

import UIKit
import Parse

class ShoppingListController : UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var addButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    var pastUrls = ["eggs", "bacon", "bread", "cheese", "milk", "beer", "juice", "soda", "steak"]
    var autocompleteUrls = [String]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        autocompleteUrls = [String]()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("hideKeyboard"))
        tapGesture.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tapGesture)

        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "my_shopping")?.drawInRect(self.view.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)
        
        self.tableView.backgroundColor = UIColor.clearColor()
        //self.tableView.backgroundView = UIImageView(image:UIImage(named: "my_shopping_edit2"))
        
        self.textField.delegate = self;
        
        self.retrieve()
    }

    @IBAction func touch(sender: AnyObject) {
        retrieve()
    }
    
    func retrieve() {
        
        autocompleteUrls = [String]()
        
        let query = PFQuery(className:"TestObject")
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                if let objects = objects as? [PFObject] {
                    
                    
                    for listItem in objects {
                        
                        let newItem:String = (listItem as PFObject)["foo"] as! String
                        self.autocompleteUrls.append(newItem)
                    }
                    
                }
                
                self.tableView.reloadData()
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    func deleteItem(food : String) {
        
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
    
    func addItemToParse() {
        
        let testObject = PFObject(className: "TestObject")
        
        testObject.ACL!.setPublicWriteAccess(true)
        
        if(textField.text != "") {
            testObject["foo"] = textField.text?.capitalizedString
            print(textField.text?.capitalizedString)
            testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                print("Object has been saved.")
            }
        }
        textField.text = "";
    }
    
    @IBAction func buttonPress(sender: UIButton) {
        
        if autocompleteUrls.contains(textField.text!.capitalizedString) {
            print("string found")
        }
        else {
            addItemToParse()
        }
        
        //refresh list
        self.retrieve()
    }
    
    @IBAction func textFieldChanged(sender: AnyObject) {
        
        //autocompleteTableView.hidden = false
        
        searchAutocompleteEntriesWithSubstring(textField.text!)
    }
    
    func searchAutocompleteEntriesWithSubstring(substring: String)
    {
        autocompleteUrls = [String]()
        
        for curString in pastUrls
        {
            if curString.lowercaseString.rangeOfString(substring.lowercaseString) != nil {
                
                autocompleteUrls.append(curString)
            }
            
        }
        
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return autocompleteUrls.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let listIdentifier = "ListItem"
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier(listIdentifier, forIndexPath: indexPath)
        let index = indexPath.row as Int
        
        cell.textLabel!.text = autocompleteUrls[index]
        
        cell.backgroundColor = UIColor.clearColor()
        
        cell.selectionStyle = .None
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let selectedCell : UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        textField.text = selectedCell.textLabel!.text
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete
        {
            let groceryData = GroceryData.sharedInstance
            
            let nameToDelete = autocompleteUrls[indexPath.row]
            
            if groceryData.inGroceryList(nameToDelete) {
                
                groceryData.unsetItemInGroceryList(nameToDelete)
                groceryData.deleteFromShoppingList(nameToDelete)
            }
            
            
            let myFood = autocompleteUrls.removeAtIndex(indexPath.row)
            
            self.deleteItem(myFood)
            
            self.tableView.reloadData()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        self.tableView.endEditing(true)
        return false
    }
    func hideKeyboard() {
        self.view.endEditing(true)
        self.tableView.endEditing(true)
    }
}