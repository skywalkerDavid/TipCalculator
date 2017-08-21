//
//  ViewController.swift
//  Tips
//
//  Created by dawei_wang on 8/20/17.
//  Copyright © 2017 dawei_wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let DEFAULT_PERCENTAGE_SETTING_KEY = "default_tip_percentage"
    let USER_BILL_AMOUNT = "user_bill_amount"
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipPercentage: UISegmentedControl!
    @IBOutlet weak var customTipField: UITextField!
    @IBOutlet weak var customTipLabel: UILabel!
    
    let CUSTOM_TIP_INDEX = 3
    let tips = [0.1, 0.15, 0.2]
    
    var userBillAmount : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        billField.becomeFirstResponder()
        
        tipPercentage.selectedSegmentIndex = UserDefaults.standard.integer(forKey: DEFAULT_PERCENTAGE_SETTING_KEY)
        
        userBillAmount = UserDefaults.standard.string(forKey: USER_BILL_AMOUNT)!
        
        if !userBillAmount.isEmpty {
            billField.text = userBillAmount
            calculateTip()
        }
        
        setBillBackgroundColor()
        
        showCustomTip(show: tipPercentage.selectedSegmentIndex == CUSTOM_TIP_INDEX)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if (!billField.text!.isEmpty) {
            userBillAmount = billField.text!
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if (!billField.text!.isEmpty) {
            let defaults = UserDefaults.standard
            defaults.set(userBillAmount, forKey: USER_BILL_AMOUNT)
            defaults.synchronize()
        }
    }
    
    func calculateTip() {
        let bill = Double(billField.text!) ?? 0
        
        var tip : Double = 0.0
        if tipPercentage.selectedSegmentIndex == CUSTOM_TIP_INDEX {
            tip = Double(customTipField.text!) ?? 0
            
            if customTipField.text!.isEmpty {
                customTipField.becomeFirstResponder()
            }
        } else {
            tip = bill * tips[tipPercentage.selectedSegmentIndex]
            customTipField.text = ""
        }
        
        let total = tip + bill
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    func setBillBackgroundColor() {
        let amount = Double(billField.text!) ?? 0.0
        if amount.isLess(than: 100.0) {
            billField.backgroundColor = UIColor.green
        } else if amount.isLess(than: 500) {
            billField.backgroundColor = UIColor.yellow
        } else {
            billField.backgroundColor = UIColor.red
        }
    }
    
    func showCustomTip(show: Bool) {
        customTipLabel.isHidden = !show
        customTipField.isHidden = !show
    }

    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func onChangeTipPercentage(_ sender: Any) {
        view.endEditing(true)
        
        if tipPercentage.selectedSegmentIndex != 3 {
            showCustomTip(show: false)
            calculateTip()
        } else {
            customTipField.alpha = 0
            customTipLabel.alpha = 0
            UIView.animate(withDuration: 0.5, animations: {
                self.customTipField.alpha = 1
                self.customTipLabel.alpha = 1
            })
            showCustomTip(show: true)
        }
    }
    
    @IBAction func onChangeBillAmount(_ sender: Any) {
        setBillBackgroundColor()
        calculateTip()
    }
    
    @IBAction func onChangeCustomTip(_ sender: Any) {
        calculateTip()
    }
    
    @IBAction func onTapCustomTip(_ sender: Any) {
        tipPercentage.selectedSegmentIndex = CUSTOM_TIP_INDEX
    }
}

