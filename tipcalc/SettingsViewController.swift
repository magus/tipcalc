//
//  SettingsViewController.swift
//  tipcalc
//
//  Created by Noah Jorgensen on 1/7/17.
//  Copyright © 2017 Noah Jorgensen. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    
    @IBOutlet weak var dollarRoundSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Correct segmented control selected state for emojis
        defaultTipControl.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.white], for:.selected)
        
        initSettings();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initSettings();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initSettings() {
        defaultTipControl.selectedSegmentIndex = Utils.getDefaultTip();
        print("dollarRound", Utils.getDollarRound());
        dollarRoundSwitch.setOn(Utils.getDollarRound(), animated: false);
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func setDollarRound(_ sender: Any) {
        print("setDollarRound", dollarRoundSwitch.isOn);
        Utils.setDollarRound(value: dollarRoundSwitch.isOn)
    }
    
    @IBAction func setDefaultTip(_ sender: Any) {
        Utils.setDefaultTip(value: defaultTipControl.selectedSegmentIndex)
    }
}
