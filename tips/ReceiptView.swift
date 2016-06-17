//
//  ReceiptView.swift
//  tips
//
//  Created by hvmark on 6/6/16.
//  Copyright © 2016 hvmark. All rights reserved.
//

import UIKit

class ReceiptView: UIView {
    
    
    @IBOutlet weak var subtotalText: UILabel!
    
    @IBOutlet weak var tipText: UILabel!
    
    @IBOutlet weak var totalText: UILabel!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "ReceiptView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    func setData(receiptData: [String: String]) {
        subtotalText.text = receiptData["subtotal"]!
        tipText.text = receiptData["tip"]!
        totalText.text = receiptData["total"]!
    }
}
