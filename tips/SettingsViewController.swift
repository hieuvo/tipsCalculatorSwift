//
//  SettingsViewController.swift
//  tips
//
//  Created by hvmark on 2/8/16.
//  Copyright © 2016 hvmark. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var pickerData = ["$", "¥", "£", "€"]
    var currentCurrency = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if defaults.valueForKey("currentCurrency") == nil {
            currentCurrency = "$"
        } else {
            currentCurrency = (defaults.valueForKey("currentCurrency") as? String)!
        }

        
        print(currentCurrency)
        if let t = pickerData.indexOf(currentCurrency) {
            print(t)
            currencyPicker.selectRow(t, inComponent: 0, animated: false)
        }
        
        
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        defaults.setValue(pickerData[row], forKey: "currentCurrency")
    }
    
    override func viewWillDisappear(animated: Bool) {
        defaults.synchronize()
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.viewDidLoad()
    }
}
