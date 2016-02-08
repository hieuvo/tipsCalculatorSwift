//
//  ViewController.swift
//  tips
//
//  Created by hvmark on 2/8/16.
//  Copyright © 2016 hvmark. All rights reserved.
//

import UIKit
import Foundation

extension Double {
    func format(f: String) -> String {
        return NSString(format: "%\(f)f", self) as String
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    let tipPercentages = [0.19, 0.20, 0.21]
    let defaults = NSUserDefaults.standardUserDefaults()
    var currentCurrency = ""
    
    var currentTipPercentage: Double = 0.20

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currency = self.getCurrency()
        
        billField.text = String(format: "\(currency)%.2f", defaults.doubleForKey("billField"))
        tipLabel.text = self.formatMoney(defaults.doubleForKey("tipLabel"))
        totalLabel.text = self.formatMoney(defaults.doubleForKey("totalLabel"))
        currentTipPercentage = defaults.doubleForKey("currentTipPercentage")

        if currentTipPercentage == 0.0 {
            currentTipPercentage = 0.20
            defaults.setDouble(currentTipPercentage, forKey: "currentTipPercentage")
        }
        
        if billField == 0.0 {
            billField.text = "0";
        }
        
        self.setSegmentText()
    }
    
    func getCurrency() -> String {
        if currentCurrency == "" {
            if defaults.valueForKey("currentCurrency") == nil {
                currentCurrency = "$"
            } else {
                currentCurrency = (defaults.valueForKey("currentCurrency") as? String)!
            }
        }

        return currentCurrency
    }
    
    func getBillAmount() -> Double {
        let currency = self.getCurrency()
        if billField.text == "" || billField.text == nil || billField.text?.characters.count == 1 {
            billField.text = currency
            return 0
        }
        
        var text = billField.text!
        text = String(text.characters.dropFirst())
        
        return Double(text)!;
    }
    
    func formatMoney(money: Double) -> String {
        return String(format: "%@%@", self.getCurrency(), String(format: "%.2f", money))
    }
    
    func formatPercentage(percent: Double) -> String {
        return String(format: "%.f%%", 100*(percent))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getTipPercentage() -> Double {
        return currentTipPercentage
    }

    @IBAction func segmentOnChanged(sender: AnyObject) {
        if tipControl.selectedSegmentIndex == 1 {
            return
        }
        
        currentTipPercentage += tipControl.selectedSegmentIndex == 0 ? -0.01 : 0.01;
        tipControl.selectedSegmentIndex = 1
        defaults.setDouble(currentTipPercentage, forKey: "currentTipPercentage")
        
        self.setSegmentText()
        self.onEditingChanged(sender)
    }
    
    func setSegmentText() {
        tipControl.setTitle(self.formatPercentage(currentTipPercentage-0.01), forSegmentAtIndex: 0)
        tipControl.setTitle(self.formatPercentage(currentTipPercentage), forSegmentAtIndex: 1)
        tipControl.setTitle(self.formatPercentage(currentTipPercentage+0.01), forSegmentAtIndex: 2)
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        let billAmount = self.getBillAmount()
        
        let tipPercentage: Double = self.getTipPercentage()
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
            
        tipLabel.text = self.formatMoney(tip)
        totalLabel.text = self.formatMoney(total)
        
        defaults.setDouble(billAmount, forKey: "billField")
        defaults.setDouble(tip, forKey: "tipLabel")
        defaults.setDouble(total, forKey: "totalLabel")
    }

    @IBAction func onTap(sender: AnyObject) {
        let billAmount = self.getBillAmount()
        if billAmount == 0 {
            billField.text = self.getCurrency()
        }

        view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.viewDidLoad()
        super.viewWillAppear(animated)
        print("view will appear")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        currentCurrency = ""
        defaults.synchronize()
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
}

