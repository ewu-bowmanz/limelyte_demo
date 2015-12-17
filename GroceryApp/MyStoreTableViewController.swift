//
//  MyStoreTableViewController.swift
//  GroceryApp
//
//  Created by Bowman on 10/29/15.
//  Copyright © 2015 Madkatz. All rights reserved.
//

import Foundation
import UIKit

class MyStoreTableViewController: UITableViewController {
    
    private var storeChoice: String  = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor.clearColor()
        //self.tableView.backgroundView = UIImageView(image:UIImage(named: "my_store_flat"))
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let myInt = indexPath.row as Int
        
        switch myInt {
            case 0:
                storeChoice = "Spokane Valley"
            case 1:
                storeChoice = "Latah Creek"
            case 2:
                storeChoice = "Post Falls"
            case 3:
                storeChoice = "Cheney"
            default:
                print("Out Of Range")
            
        }
        
        let myStore = MyStore.sharedInstance
        
        myStore.setStoreChoice(self.storeChoice)
    }
}