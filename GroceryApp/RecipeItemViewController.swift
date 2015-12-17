//
//  RecipeItemViewController.swift
//  GroceryApp
//
//  Created by Bowman on 11/21/15.
//  Copyright © 2015 Madkatz. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class RecipeItemViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet var collectionView: UICollectionView!
    private let reuseIdentifier = "RecipeItemCell"
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 50.0, right: 20.0)
    private let sections = 1
    
    private var images = [UIImage]()
    private var recipes = [RecipeItem]()
    private var selectedCategory = String("")
    
    
    override func viewDidLoad() {
        
        let recipeData = RecipeData.sharedInstance
        
        if selectedCategory != "" {
            recipes = recipeData.getGroceryListMatchingQuery(selectedCategory.lowercaseString)
        } else {
            recipes = recipeData.getRecipeList()
        }
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "my_recipes")?.drawInRect(self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        self.collectionView!.backgroundColor = UIColor.clearColor()
        //self.collectionView!.backgroundView = UIImageView(image:UIImage(named: "weekly_specials_flat"))
        //print(recipes.count)
        
    }
    
    func setSelectedCategory(category: String) {
        selectedCategory = category
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        let indexPath = self.collectionView?.indexPathForCell(sender as! RecipeItemCell)
        let dvc = segue.destinationViewController as! RecipePageViewController
        dvc.recipeItem = recipes[indexPath!.row]

    }
    
}

extension RecipeItemViewController {
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return sections
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return recipes.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! RecipeItemCell
        
        let image = recipes[indexPath.item].image
        cell.recipeItem = recipes[indexPath.item]
        cell.imageView.image = image
        //cell.priceLabel.text = "$" + groceries[indexPath.row].price.description
        cell.layer.cornerRadius = 15.0
        
        
        return cell
    }
    
}


extension RecipeItemViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            
            let frameWidth = self.view.frame.width
            let cellSideLength = (frameWidth - (20 * 3))/2
            
            
            return CGSize(width: cellSideLength, height: cellSideLength)
    }
    
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
}
