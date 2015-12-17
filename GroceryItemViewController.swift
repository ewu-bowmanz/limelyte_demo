//
//  GroceryItemViewController.swift
//  GroceryApp
//
//

import Foundation
import UIKit
import CoreData

class GroceryItemViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet var collectionView: UICollectionView!
    private let reuseIdentifier = "GroceryItemCell"
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 50.0, right: 20.0)
    private let sections = 1
    
    private var images = [UIImage]()
    private var groceries = [GroceryItem]()
    private var selectedCategory = String("")
    
    
    override func viewDidLoad() {
        
        let groceryData = GroceryData.sharedInstance
        
        if selectedCategory != "" {
            groceries = groceryData.getGroceryListMatchingQuery(selectedCategory.lowercaseString)
        } else {
            groceries = groceryData.getGroceryList()
        }
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "weekly_specials_flat")?.drawInRect(self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        self.collectionView!.backgroundColor = UIColor.clearColor()
        //self.collectionView!.backgroundView = UIImageView(image:UIImage(named: "weekly_specials_flat"))
        
    }
    
    func setSelectedCategory(category: String) {
        selectedCategory = category
    }
    
}

extension GroceryItemViewController {
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return sections
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return groceries.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! GroceryItemCell
        
        let image = groceries[indexPath.item].image
        cell.groceryItem = groceries[indexPath.item]
        cell.imageView.image = image
        //cell.priceLabel.text = "$" + groceries[indexPath.row].price.description
        cell.layer.cornerRadius = 15.0
        
        //let name = groceries[indexPath.item].name
        if groceries[indexPath.item].inShoppingList == 1 {
            cell.setMinusButton()
        } else {
            cell.setPlusButton()
        }
        
        
        return cell
    }
    
}


extension GroceryItemViewController : UICollectionViewDelegateFlowLayout {
    
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
