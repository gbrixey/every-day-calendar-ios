//
//  Colors.swift
//  EveryDayCalendar
//
//  Created by Glen Brixey on 3/8/19.
//  Copyright © 2019 Glen Brixey. All rights reserved.
//

import UIKit

enum Colors {
    static let blue = UIColor(hex: 0xD5F3FD)
    static let gray = UIColor(hex: 0xE6E6E6)
    static let yellow = UIColor(hex: 0xFDCF00)
}

private extension UIColor {

    convenience init(hex: Int) {
        self.init(red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(hex & 0x0000FF) / 255.0,
                  alpha: 1.0)
    }
}
