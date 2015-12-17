//
//  SearchViewController.swift
//  GroceryApp
//
//

import Foundation
import UIKit

class SearchViewController : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBAction func searchBtnPress(sender: AnyObject) {
        entry = textField.text!
    }
    
    private var entry = String()
    
    
    override func viewDidLoad() {
        textField.delegate = self
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "login_flat")!)
        searchButton.layer.cornerRadius = 6.0

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dvc = segue.destinationViewController as! GroceryItemViewController
        dvc.setSelectedCategory(self.textField.text!)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchBtnPress(searchButton)
        
        return true
    }
    
}
