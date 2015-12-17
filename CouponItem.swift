//
//  CouponItem.swift
//  GroceryApp
//
//

import Foundation
import UIKit

class CouponItem  {
        
    var name = String()
    var category = String()
    var image = UIImage()
    var barCode = UIImage()
    var dealString = String()
        
    func setImage(image: UIImage) {
        self.image = image
    }
        
    func setBarcodeImage(image: UIImage) {
        barCode = image
    }
        
    func setName(name: String) {
        self.name = name
    }
        
    func setDealString(dealString: String) {
        self.dealString = dealString
    }
        
    func setCategory(category: String) {
        self.category = category
    }
    
    func getBarcode() -> UIImage {
        return barCode
    }
    
}
