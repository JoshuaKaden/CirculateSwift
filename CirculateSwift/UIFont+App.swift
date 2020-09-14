//
//  UIFont+App.swift
//  ThreeOneOne
//
//  Created by Kaden, Joshua on 10/27/15.
//  Copyright © 2015 NYC DoITT. All rights reserved.
//

import UIKit

enum AppFontWeight {
    case black, bold, heavy, light, medium, regular, semibold, thin, ultralight
    
    func uiFontWeight() -> CGFloat {
        switch self {
        case .black:
            return UIFont.Weight.black.rawValue
        case .bold:
            return UIFont.Weight.bold.rawValue
        case .heavy:
            return UIFont.Weight.heavy.rawValue
        case .light:
            return UIFont.Weight.light.rawValue
        case .medium:
            return UIFont.Weight.medium.rawValue
        case .regular:
            return UIFont.Weight.regular.rawValue
        case .semibold:
            return UIFont.Weight.semibold.rawValue
        case .thin:
            return UIFont.Weight.thin.rawValue
        case .ultralight:
            return UIFont.Weight.ultraLight.rawValue
        }
    }
}

extension UIFont {
    
    @objc class func appBoldFontOfSize(_ size: CGFloat) -> UIFont {
        return appFont(size: size, weight: .bold)
    }
    
    class func appFont(isFixed: Bool = false, size: CGFloat, textStyle: UIFont.TextStyle = .body, weight: AppFontWeight) -> UIFont {
        guard !isFixed else { return systemFont(ofSize: size, weight: UIFont.Weight(rawValue: weight.uiFontWeight())) }
        return preferredSystemFont(size: size, textStyle: textStyle, weight: weight.uiFontWeight())
    }
    
    private class func preferredSystemFont(size: CGFloat, textStyle: UIFont.TextStyle = .body, weight: CGFloat) -> UIFont {
        let preferredSize = UIFontDescriptor.calculatePreferredSize(baseSize: size, textStyle: textStyle)
        return systemFont(ofSize: preferredSize, weight: UIFont.Weight(rawValue: weight))
    }
}
