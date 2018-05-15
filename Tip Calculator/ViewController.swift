//
//  ViewController.swift
//  Tip Calculator
//
//  Created by James Young on 2/1/18.
//  Copyright © 2018 James Young. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var totalBill: UITextField!
    @IBOutlet var tip10: UITextField!
    @IBOutlet var tip15: UITextField!
    @IBOutlet var tip20: UITextField!
    @IBOutlet var total10: UITextField!
    @IBOutlet var total15: UITextField!
    @IBOutlet var total20: UITextField!
    @IBOutlet var customSlider: UISlider!
    @IBOutlet var customPercent: UILabel!
    @IBOutlet var customTip: UITextField!
    @IBOutlet var customTotal: UITextField!
    
    let tips = Tip()
    
    override func viewDidLoad() {
        
        //totalBill.addTarget(self, action: #selector(totalBillUpdated), for: UIControlEvents.editingChanged)
        
        super.viewDidLoad()
        
        totalBill.delegate = self
        loadPadding(textField : totalBill)
        loadPadding(textField : tip10)
        loadPadding(textField : tip15)
        loadPadding(textField : tip20)
        loadPadding(textField : total10)
        loadPadding(textField : total15)
        loadPadding(textField : total20)
        loadPadding(textField : customTip)
        loadPadding(textField : customTotal)
        customSlider.minimumValue = 0
        customSlider.maximumValue = 100
        customSlider.addTarget(self, action: #selector(ViewController.sliderValueChanged(_:)), for: .valueChanged)
        self.view.addSubview(customSlider)
        /*
        //Padding for the Bill Total text field
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.totalBill.frame.height))
        totalBill.leftView = paddingView
        totalBill.leftViewMode = UITextFieldViewMode.always
        
        //Padding for the 10% Tip text field
        let paddingViewTip10 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.tip10.frame.height))
        tip10.leftView = paddingViewTip10
        tip10.leftViewMode = UITextFieldViewMode.always
        
        //Padding for the 15% Tip text field
        let paddingViewTip15 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.tip15.frame.height))
        tip15.leftView = paddingViewTip15
        tip15.leftViewMode = UITextFieldViewMode.always
        
        //Padding for the 20% Tip text field
        let paddingViewTip20 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.tip20.frame.height))
        tip20.leftView = paddingViewTip20
        tip20.leftViewMode = UITextFieldViewMode.always
        
        //Padding for the Total with 10% tip text field
        let paddingViewTotal10 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.total10.frame.height))
        total10.leftView = paddingViewTotal10
        total10.leftViewMode = UITextFieldViewMode.always
        
        //Padding for the Total with 15% tip text field
        let paddingViewTotal15 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.total15.frame.height))
        total15.leftView = paddingViewTotal15
        total15.leftViewMode = UITextFieldViewMode.always
        
        //Padding for the Total with 20% tip text field
        let paddingViewTotal20 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.total20.frame.height))
        total20.leftView = paddingViewTotal20
        total20.leftViewMode = UITextFieldViewMode.always
        
        //Padding for the Custom tip text field
        let paddingViewCustomTip = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.customTip.frame.height))
        customTip.leftView = paddingViewCustomTip
        customTip.leftViewMode = UITextFieldViewMode.always
        
        //Padding for the Total with custom tip text field
        let paddingViewCustomTotal = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.customTotal.frame.height))
        customTotal.leftView = paddingViewCustomTotal
        customTotal.leftViewMode = UITextFieldViewMode.always
        */
        totalBill.becomeFirstResponder()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        
        print("Memory hi")
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadPadding(textField : UITextField!)
    {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextFieldViewMode.always
    }

    // MARK: - Button Actions -
    @IBAction func sliderValueChanged(_ sender: UISlider!)
    {
        customPercent.text! = String(format:"%d%%", Int(self.customSlider.value))
        if let bill = Double(totalBill.text!)
        {
            calculateCustom(toCalc: bill)
        }
    }
    
    @IBAction func totalBillUpdated (sender: AnyObject)
    {
        if let bill = Double(totalBill.text!)
        {
            calculateTips(toCalc: bill)
            calculateTotal(toCalc: bill)
            calculateCustom(toCalc: bill)
        }
        else
        {
            tip10.text! = "0.00"
            tip15.text! = "0.00"
            tip20.text! = "0.00"
            total10.text! = "0.00"
            total15.text! = "0.00"
            total20.text! = "0.00"
            customTip.text! = "0.00"
        }
    }
    
    func calculateCustom(toCalc : Double)
    {
        customTip.text! = String(format: "%.2f", toCalc * Double(customSlider.value / 100))
        customTotal.text! = String(format: "%.2f", toCalc * (1 + Double(customSlider.value / 100)))
    }
    
    func calculateTips(toCalc : Double)
    {
        tip10.text! = String(format: "%.2f", toCalc * tips.getTips(0))
        tip15.text! = String(format: "%.2f", toCalc * tips.getTips(1))
        tip20.text! = String(format: "%.2f", toCalc * tips.getTips(2))
    }
    
    func calculateTotal(toCalc: Double)
    {
        total10.text! = String(format: "%.2f", toCalc * (1 + tips.getTips(0)))
        total15.text! = String(format: "%.2f", toCalc * (1 + tips.getTips(1)))
        total20.text! = String(format: "%.2f", toCalc * (1 + tips.getTips(2)))
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if string.isEmpty
        {
            return true
        }
        
        let currentText = textField.text ?? ""
        let replacementText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        return replacementText.isValidDouble(maxDecimals: 2)
    }
}

