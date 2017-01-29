//
//  ViewController.swift
//  tipcalc
//
//  Created by Noah Jorgensen on 1/7/17.
//  Copyright © 2017 Noah Jorgensen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipSelected: UISegmentedControl!
    
    let screenSize: CGRect = UIScreen.main.bounds;
    let tipPercentages = [0.10, 0.15, 0.20];
    var keyboardHeight = 216.0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Correct segmented control selected state for emojis
        tipSelected.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.white], for:.selected)
        
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
    
    func formatCurrency(amount: Double)-> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency;
        formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale!
        return formatter.string(from: amount as NSNumber)!;
    }
    
    func formatPercent(amount: Double)-> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.percent;
        formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale!
        return formatter.string(from: amount as NSNumber)!;
    }
    
    func getBill()-> Double {
        let billText = billField.text ?? "";
        let billNumbers = billText.components(
            separatedBy: NSCharacterSet.decimalDigits.inverted
        );
        
        let billNumeric = Double(billNumbers.joined(separator: ""));
        if (billNumeric == nil) {
            return 0;
        }
        
        return 0.01 * billNumeric!;
    }
    
    func updateBill() {
        let bill = getBill();
        
        if (bill <= 0) {
            billField.text = nil;
            return;
        }
        
        billField.text = formatCurrency(amount: bill);
    }
    
    func setLabels() {
        let bill = getBill();
        var tip = bill * tipPercentages[tipSelected.selectedSegmentIndex];
        var total = tip + bill;
        
        // Setting flag to round to nearest dollar
        // e.g. 36.78 will round tip to get 37.00 total
        // math: integer the total, add one, subtract total from target, add difference to tip
        // e.g. [4.78] 36.68 -> 36 + 1 = 37 -> 37 - 36.68 = 0.32 -> 0.32 + 4.78 = 5.10 tip
        if (bill != 0 && Utils.getDollarRound()) {
            let target = round(total) >= 1 ? round(total) : 1;
            let change = target - total;
            tip += change;
            total = tip + bill;
        }
        
        tipLabel.text = String(format: "%@ (%@)", formatCurrency(amount: tip), formatPercent(amount: total == 0 ? 0 : tip/bill));
        totalLabel.text = formatCurrency(amount: total);
        
        updateBill();
    }
    
    func positionTipControl() {
        let tipSelectHeight = Double(self.tipSelected.frame.height);
        let yPos = Double(self.screenSize.height) - self.keyboardHeight - tipSelectHeight - 10.0;
        
        if ((self.billField.text) != "") {
            self.tipSelected.frame.origin.y = CGFloat(yPos);
            self.tipSelected.alpha = 1.0;
        } else {
            self.tipSelected.frame.origin.y = CGFloat(yPos + (2 * tipSelectHeight));
            self.tipSelected.alpha = 0.0;
        }
    }
    
    func mainViewBackground() {
        if (self.billField.text != "") {
            self.mainView.backgroundColor = Colors.MoneyGreen;
        } else {
            self.mainView.backgroundColor = UIColor.white;
        }
    }
    
    func positionTip() {
        if (self.billField.text != "") {
            self.tipLabel.frame.origin.x = 0;
        } else {
            self.tipLabel.frame.origin.x = self.screenSize.width;
        }
    }
    
    func positionTotal() {
        if (self.billField.text != "") {
            self.totalLabel.frame.origin.x = 0;
        } else {
            self.totalLabel.frame.origin.x = self.screenSize.width;
        }
    }
    
    func updatePositions() {
        // Replace with a good spring
        // e.g. https://github.com/facebook/pop
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            
            self.positionTipControl();
            self.mainViewBackground();
            
            self.positionTip();
            self.positionTotal();
            
            // TODO: Decrease font size of bill and slide up
            // TODO: Slide in tip and total from right, below bill
            
            // TODO: Increase font size of tip
            // TODO: Increase font size of total
            
        }, completion: {
            (completed: Bool) in
            // print("animation completed", completed);
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

