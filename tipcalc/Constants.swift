//
//  Constants.swift
//  tipcalc
//
//  Created by Noah Jorgensen on 1/7/17.
//  Copyright © 2017 Noah Jorgensen. All rights reserved.
//

import UIKit
import Foundation



struct Settings {
    static let DefaultTip = "Tipcalc_SettingKey_DefaultTip";
    static let DollarRound = "Tipcalc_SettingKey_DollarRound";
}

struct Colors {
    static let Lighten = CGFloat(1.35);
    static let MoneyGreen = UIColor.init(red: Colors.Lighten*(133.0/255.0), green: Colors.Lighten*187.0/255.0, blue: Colors.Lighten*101.0/255.0, alpha: 1.0);
}
