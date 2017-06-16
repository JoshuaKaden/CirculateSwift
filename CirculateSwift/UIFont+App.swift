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
            return UIFontWeightBlack
        case .bold:
            return UIFontWeightBold
        case .heavy:
            return UIFontWeightHeavy
        case .light:
            return UIFontWeightLight
        case .medium:
            return UIFontWeightMedium
        case .regular:
            return UIFontWeightRegular
        case .semibold:
            return UIFontWeightSemibold
        case .thin:
            return UIFontWeightThin
        case .ultralight:
            return UIFontWeightUltraLight
        }
    }
}

extension UIFont {
    
    @objc class func appBoldFontOfSize(_ size: CGFloat) -> UIFont {
        return appFont(size: size, weight: .bold)
    }
    
    class func appFont(isFixed: Bool = false, size: CGFloat, textStyle: UIFontTextStyle = .body, weight: AppFontWeight) -> UIFont {
        guard !isFixed else { return systemFont(ofSize: size, weight: weight.uiFontWeight()) }
        return preferredSystemFont(size: size, weight: weight.uiFontWeight())
    }
    
    private class func preferredSystemFont(size: CGFloat, textStyle: UIFontTextStyle = .body, weight: CGFloat) -> UIFont {
        let preferredSize = UIFontDescriptor.calculatePreferredSize(baseSize: size, textStyle: textStyle)
        return systemFont(ofSize: preferredSize, weight: weight)
    }
}
