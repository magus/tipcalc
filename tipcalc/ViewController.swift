//
//  ViewController.swift
//  tipcalc
//
//  Created by Noah Jorgensen on 1/7/17.
//  Copyright © 2017 Noah Jorgensen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipSelected: UISegmentedControl!
    
    let tipPercentages = [0.15, 0.20, 0.25];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        onViewOpen();
        
        // Listen for keyboard frame changes
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        onViewOpen();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil);
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? CGRect {
            print("keyboardSize.height", keyboardSize.height);
        }
    }

    
    func onViewOpen() {
        setDefaultTip();
        setLabels();
        billField.becomeFirstResponder();
    }
    
    func setDefaultTip() {
        tipSelected.selectedSegmentIndex = Utils.getDefaultTip();
    }
    
    func setLabels() {
        let bill = Double(billField.text!) ?? 0;
        let tip = bill * tipPercentages[tipSelected.selectedSegmentIndex];
        let total = tip + bill;
        
        tipLabel.text = String(format: "$%.2f", tip);
        totalLabel.text = String(format: "$%.2f", total);
    }

    @IBAction func onTap(_ sender: Any) {
        // // Dismiss keyboard
        // billField.resignFirstResponder();
    }

    @IBAction func calculateTip(_ sender: AnyObject) {
        setLabels();
    }
}

