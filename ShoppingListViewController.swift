//
//  ShoppingListViewController.swift
//  GroceryApp
//
//  Created by Chris Larkin on 7/26/15.
//  Copyright (c) 2015 Madkatz. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class ShoppingListViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var shoppingList = [GroceryItem]()
    
    override func viewDidLoad() {
        let groceryData = GroceryData.sharedInstance
        shoppingList = groceryData.getShoppingList()
        
    }
    
    
    
    
    
    //# MARK: - TableView Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("basicCell") as! UITableViewCell
        cell.textLabel?.text = shoppingList[indexPath.row].name
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}