//
//  SearchViewController.swift
//  GroceryApp
//
//

import Foundation
import UIKit

class StoreMapViewController : UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBAction func btnPushed(Sender: AnyObject) {
        let alert = UIAlertController(title: textField.text, message: "Aisle 7", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Close", style: .Cancel, handler: {
            action in
            
        })
        
        alert.addAction(cancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }

        
    
    
    override func viewDidLoad() {
        textField.delegate = self
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        btnPushed(button)
        return true
    }

}