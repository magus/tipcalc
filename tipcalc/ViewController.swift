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
    
    let screenSize: CGRect = UIScreen.main.bounds;
    let tipPercentages = [0.15, 0.20, 0.25];
    var keyboardHeight = 216.0;
    
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
        if let keyboardRect = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? CGRect {
            keyboardHeight = Double(keyboardRect.height);
        }
    }

    
    func onViewOpen() {
        setDefaultTip();
        setLabels();
        billField.becomeFirstResponder();
        
        positionTipControl();
    }
    
    func setDefaultTip() {
        tipSelected.selectedSegmentIndex = Utils.getDefaultTip();
    }
    
    func updateBill() {
        let billText = billField.text! as NSString;
        
        if (billText == "") {
            billField.text = nil;
            return;
        }
        
        let billNumbers = billText.components(
            separatedBy: NSCharacterSet.decimalDigits.inverted
        );
        let billCents = 0.01 * Double(billNumbers.joined(separator: ""))!;
        
        if (billCents <= 0) {
            billField.text = nil;
            return;
        }
        
        billField.text = String(format: "$%.2f", billCents);
    }
    
    func setLabels() {
        let bill = Double(billField.text!) ?? 0;
        let tip = bill * tipPercentages[tipSelected.selectedSegmentIndex];
        let total = tip + bill;
        
        tipLabel.text = String(format: "$%.2f", tip);
        totalLabel.text = String(format: "$%.2f", total);
        
        updateBill();
    }
    
    func positionTipControl() {
        let tipSelectHeight = Double(self.tipSelected.frame.height);
        let yPos = Double(self.screenSize.height) - self.keyboardHeight - tipSelectHeight - 10.0;
        
        if ((self.billField.text) != "") {
            self.tipSelected.frame.origin.y = CGFloat(yPos);
        } else {
            self.tipSelected.frame.origin.y = CGFloat(yPos + (2 * tipSelectHeight));
        }
    }
    
    func updatePositions() {
        // Replace with a good spring
        // e.g. https://github.com/facebook/pop
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.positionTipControl();
        }, completion: {
            (completed: Bool) in
            print("animation completed", completed);
        });
    }

    @IBAction func onTap(_ sender: Any) {
        // // Dismiss keyboard
        // billField.resignFirstResponder();
    }

    @IBAction func calculateTip(_ sender: AnyObject) {
        setLabels();
        updatePositions();
    }
}

