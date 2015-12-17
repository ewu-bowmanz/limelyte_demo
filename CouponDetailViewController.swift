//
//  CouponDetailViewController.swift
//  GroceryApp
//
//  Created by Chris Larkin on 9/2/15.
//  Copyright (c) 2015 Madkatz. All rights reserved.
//

import Foundation
import UIKit


class CouponDetailViewController : UIViewController {
    @IBOutlet weak var barcodeImageView: UIImageView!
    
    var barcodeImage : UIImage
    
    required init?(coder aCoder: NSCoder) {
        barcodeImage = UIImage()
        super.init(coder: aCoder)
    }
    
    func setImage(image: UIImage) {
        barcodeImage = image
    }
    
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear(animated: Bool) {
        barcodeImageView.image = barcodeImage
    }
    
    
    
    
}
