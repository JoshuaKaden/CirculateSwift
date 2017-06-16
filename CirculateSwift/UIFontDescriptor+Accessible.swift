//
//  UIFontDescriptor+Accessible.swift
//  ThreeOneOne
//
//  Created by Kaden, Joshua on 2/28/17.
//  Copyright © 2017 NYC DoITT. All rights reserved.
//

import UIKit

/// http://stackoverflow.com/questions/20510094/how-to-use-a-custom-font-with-dynamic-text-sizes-in-ios7/20510095#20510095
extension UIFontDescriptor {
    
    private static let defaultBodyFontSize = CGFloat(17)

    @nonobjc private static var fontSizeTable: [UIFontTextStyle : [UIContentSizeCategory : CGFloat]] = {
        return [
            .headline: [
                .accessibilityExtraExtraExtraLarge: 23,
                .accessibilityExtraExtraLarge: 23,
                .accessibilityExtraLarge: 23,
                .accessibilityLarge: 23,
                .accessibilityMedium: 23,
                .extraExtraExtraLarge: 23,
                .extraExtraLarge: 21,
                .extraLarge: 19,
                .large: 17,
                .medium: 16,
                .small: 15,
                .extraSmall: 14],
            .subheadline: [
                .accessibilityExtraExtraExtraLarge: 21,
                .accessibilityExtraExtraLarge: 21,
                .accessibilityExtraLarge: 21,
                .accessibilityLarge: 21,
                .accessibilityMedium: 21,
                .extraExtraExtraLarge: 21,
                .extraExtraLarge: 19,
                .extraLarge: 17,
                .large: 15,
                .medium: 14,
                .small: 13,
                .extraSmall: 12],
            .body: [
                .accessibilityExtraExtraExtraLarge: 53,
                .accessibilityExtraExtraLarge: 47,
                .accessibilityExtraLarge: 40,
                .accessibilityLarge: 33,
                .accessibilityMedium: 28,
                .extraExtraExtraLarge: 23,
                .extraExtraLarge: 21,
                .extraLarge: 19,
                .large: 17,
                .medium: 16,
                .small: 15,
                .extraSmall: 14],
            .caption1: [
                .accessibilityExtraExtraExtraLarge: 18,
                .accessibilityExtraExtraLarge: 18,
                .accessibilityExtraLarge: 18,
                .accessibilityLarge: 18,
                .accessibilityMedium: 18,
                .extraExtraExtraLarge: 18,
                .extraExtraLarge: 16,
                .extraLarge: 14,
                .large: 12,
                .medium: 11,
                .small: 11,
                .extraSmall: 11],
            .caption2: [
                .accessibilityExtraExtraExtraLarge: 17,
                .accessibilityExtraExtraLarge: 17,
                .accessibilityExtraLarge: 17,
                .accessibilityLarge: 17,
                .accessibilityMedium: 17,
                .extraExtraExtraLarge: 17,
                .extraExtraLarge: 15,
                .extraLarge: 13,
                .large: 11,
                .medium: 11,
                .small: 11,
                .extraSmall: 11],
            .footnote: [
                .accessibilityExtraExtraExtraLarge: 19,
                .accessibilityExtraExtraLarge: 19,
                .accessibilityExtraLarge: 19,
                .accessibilityLarge: 19,
                .accessibilityMedium: 19,
                .extraExtraExtraLarge: 19,
                .extraExtraLarge: 17,
                .extraLarge: 15,
                .large: 13,
                .medium: 12,
                .small: 12,
                .extraSmall: 12],
        ]
    }()
    
    open class func calculatePreferredSize(baseSize: CGFloat, textStyle: UIFontTextStyle = .body) -> CGFloat {
        let sizeOffset = baseSize - defaultBodyFontSize
        return currentPreferredSize(textStyle: textStyle) + sizeOffset
    }
    
    private class func currentPreferredSize(textStyle: UIFontTextStyle = .body) -> CGFloat {
        let contentSize = UIApplication.shared.preferredContentSizeCategory
        guard let style = fontSizeTable[textStyle], let fontSize = style[contentSize] else { return 17 }
        return fontSize
    }
}
