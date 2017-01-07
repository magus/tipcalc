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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setDefaultTip();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setDefaultTip();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDefaultTip() {
        defaultTipControl.selectedSegmentIndex = Utils.getDefaultTip();
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func setDefaultTip(_ sender: Any) {
        let defaults = UserDefaults.standard;
        defaults.set(defaultTipControl.selectedSegmentIndex, forKey: Settings.DefaultTip);
        defaults.synchronize();
    }
}
