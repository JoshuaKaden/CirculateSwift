//
//  VeinModel.swift
//  CirculateSwift
//
//  Created by Joshua Kaden on 7/9/17.
//  Copyright © 2017 Chadford Software. All rights reserved.
//

import UIKit

struct VeinModel {
    let vein: Vein
    
    let borderColor: UIColor
    var borderColorLight: UIColor {
        switch vein {
        case .hepaticPortal, .pulmonary:
            return .lightOxygenated
        default:
            return .lightDeoxygenated
        }
    }
    
    let borderWidth: CGFloat
    let fillColor: UIColor = .clear
    
    var systemOrigins: [SystemConnection]? {
        switch vein {
        case .gonadal:
            return [
                SystemConnection(locale: .leftBottom, system: .lowerBody)
            ]
        case .hepatic:
            return [
                SystemConnection(locale: .leftBottom, system: .liver)
            ]
        case .hepaticPortal:
            return [
                SystemConnection(locale: .bottomLeft, system: .gut)
            ]
        case .iliac:
            return [
                SystemConnection(locale: .bottomLeft, system: .leftLeg),
                SystemConnection(locale: .bottomLeft, system: .rightLeg)
            ]
        case .inferiorVenaCava:
            return [
                SystemConnection(locale: .bottomLeft, system: .leftLeg)
            ]
        case .jugular:
            return [
                SystemConnection(locale: .leftBottom, system: .head)
            ]
        case .pulmonary:
            return [
                SystemConnection(locale: .bottomRight, system: .leftLung),
                SystemConnection(locale: .bottomRight, system: .rightLung)
            ]
        case .renal:
            return [
                SystemConnection(locale: .bottomLeft, system: .leftKidney),
                SystemConnection(locale: .bottomLeft, system: .rightKidney)
            ]
        case .subclavian:
            return [
                SystemConnection(locale: .bottomLeft, system: .leftArm),
                SystemConnection(locale: .bottomLeft, system: .rightArm)
            ]
        case .superiorVenaCava:
            return [
                SystemConnection(locale: .leftBottom, system: .head)
            ]
        }
    }
    
    var systemTermini: [SystemConnection]? {
        switch vein {
        case .gonadal:
            return nil
        case .hepatic:
            return nil
        case .hepaticPortal:
            return [
                SystemConnection(locale: .bottomRight, system: .liver)
            ]
        case .iliac:
            return nil
        case .inferiorVenaCava:
            return [
                SystemConnection(locale: .leftBottom, system: .heart)
            ]
        case .jugular:
            return nil
        case .pulmonary:
            return [
                SystemConnection(locale: .rightTop, system: .heart)
            ]
        case .renal:
            return nil
        case .subclavian:
            return nil
        case .superiorVenaCava:
            return [
                SystemConnection(locale: .left, system: .heart)
            ]
        }
    }
}

// MARK: - Custom initializer

extension VeinModel {
    init(vein: Vein, borderWidth: CGFloat = 3, isHighlighted: Bool = false) {
        self.vein = vein
        switch vein {
        case .hepaticPortal, .pulmonary:
            if isHighlighted {
                borderColor = .lightOxygenated
            } else {
                borderColor = .oxygenated
            }
        default:
            if isHighlighted {
                borderColor = .lightDeoxygenated
            } else {
                borderColor = .deoxygenated
            }
        }
        self.borderWidth = borderWidth
    }
}
