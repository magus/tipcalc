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
        
        let tipSelectHeight = Double(self.tipSelected.frame.height);
        let yPos = Double(self.screenSize.height) - self.keyboardHeight - tipSelectHeight - 10.0;
        
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 0.35, initialSpringVelocity: 0.2, options: .curveEaseOut, animations: {
            if ((self.billField.text) != "") {
                self.tipSelected.frame.origin.y = CGFloat(yPos);
            } else {
                self.tipSelected.frame.origin.y = CGFloat(yPos + (2 * tipSelectHeight));
            }
        }, completion: {
            (completed: Bool) in
            print("animation finished");
        });
    }
}

