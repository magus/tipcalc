//
//  Utils.swift
//  tipcalc
//
//  Created by Noah Jorgensen on 1/7/17.
//  Copyright © 2017 Noah Jorgensen. All rights reserved.
//

import Foundation

class Utils {
    static let defaults = UserDefaults.standard;
    
    static func setDefaultTip(value: Int) {
        defaults.set(value, forKey: Settings.DefaultTip);
        defaults.synchronize();
    }
    
    static func setDollarRound(value: Bool) {
        defaults.set(value, forKey: Settings.DollarRound);
        defaults.synchronize();
    }
    
    static func getDefaultTip() -> Int {
        return Utils.defaults.integer(forKey: Settings.DefaultTip);
    }
    
    static func getDollarRound() -> Bool {
        return Utils.defaults.bool(forKey: Settings.DollarRound);
    }
}
