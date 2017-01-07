//
//  Utils.swift
//  tipcalc
//
//  Created by Noah Jorgensen on 1/7/17.
//  Copyright © 2017 Noah Jorgensen. All rights reserved.
//

import Foundation

class Utils {
    static func getDefaultTip() -> Int {
        let defaults = UserDefaults.standard;
        return defaults.integer(forKey: Settings.DefaultTip);
    }
}
