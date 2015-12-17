//
//  MainViewController.swift
//  GroceryApp
//
//  Created by Chris Larkin on 7/22/15.
//  Copyright (c) 2015 Madkatz. All rights reserved.
//

import Foundation
import UIKit


class MainViewController : UITableViewController {
    
    
    @IBOutlet var myStoreTF: UILabel!
    @IBOutlet var fakeFoods: UIView!
    override func viewDidLoad() {
        
        
        let groceryData = GroceryData.sharedInstance
        
        groceryData.addGroceryItems()
        groceryData.addCouponItems()
        groceryData.retrieveFromParse()
        
        let recipeData = RecipeData.sharedInstance
        
        recipeData.addRecipes()
        
        //fakeFoods.frame = CGRectMake(0, 64, 400, 260)
        
        self.tableView.backgroundView = UIImageView(image:UIImage(named: "menu"))
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        let myStore = MyStore.sharedInstance
        myStoreTF.text = myStore.getStoreChoice()
    }
    
}