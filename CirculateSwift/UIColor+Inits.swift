//
//  UIColor+Inits.swift
//  CirculateSwift
//
//  Created by Joshua Kaden on 6/25/17.
//  Copyright © 2017 Chadford Software. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(easyRed: Int, easyGreen: Int, easyBlue: Int, alpha: Double) {
        self.init(red: CGFloat(easyRed)/CGFloat(255), green: CGFloat(easyGreen)/CGFloat(255), blue: CGFloat(easyBlue)/CGFloat(255), alpha: CGFloat(alpha))
    }
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
