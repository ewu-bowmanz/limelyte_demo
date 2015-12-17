//
//  CouponItemViewController.swift
//  GroceryApp
//
//

import Foundation
import UIKit


class CouponItemViewController : UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let reuseIdentifier = "CouponCell"
    private var couponList = [CouponItem]()
    
    override func viewDidLoad() {
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "coupons_flat")?.drawInRect(self.view.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "coupons_flat")!)

        
        //self.tableView.backgroundView = UIImageView(image:UIImage(named: "coupons_flat"))
        
        self.tableView.backgroundColor = UIColor.clearColor()
        
        let groceryData = GroceryData.sharedInstance
        couponList = groceryData.getCouponList()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let currentIndexPath = tableView.indexPathForSelectedRow
        
        let dvc = segue.destinationViewController as! CouponDetailViewController
        dvc.setImage(couponList[currentIndexPath!.row].getBarcode())
    }
    
    //# MARK: - TableView Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return couponList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> CouponCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as! CouponCell
        
        //cell.accessoryType = UITableViewCellAccessoryType.None
        
        let coupon = couponList[indexPath.row]
        //let ns = NSNumberFormatter()
        //ns.numberStyle = .DecimalStyle
        //let dealString = ns.stringFromNumber(coupon.price)
        
        let dealString = coupon.dealString
        cell.priceLabel.text = dealString
        cell.barcodeImageView.image = coupon.barCode
        cell.mainImageView.image = coupon.image
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
