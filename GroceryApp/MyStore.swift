//
//  MyStore.swift
//  GroceryApp
//
//  Created by Bowman on 9/4/15.
//  Copyright (c) 2015 Madkatz. All rights reserved.
//

import Foundation
import UIKit

private let _StoreSharedInstance = MyStore()

class MyStore: UIViewController, UITableViewDelegate {
    
    class var sharedInstance: MyStore {
        return _StoreSharedInstance
    }
    
    private var storeChoice: String  = ""
    
    func getStoreChoice() -> String {
        return storeChoice
    }
    
    func setStoreChoice(choice : String) {
        storeChoice = choice
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "my_store_flat")?.drawInRect(self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        //self.tableView.backgroundColor = UIColor.clearColor()
        //self.tableView.backgroundView = UIImageView(image:UIImage(named: "my_store_flat"))
        
    }
}