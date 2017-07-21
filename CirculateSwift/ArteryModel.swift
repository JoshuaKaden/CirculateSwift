//
//  ArteryModel.swift
//  CirculateSwift
//
//  Created by Joshua Kaden on 6/30/17.
//  Copyright © 2017 Chadford Software. All rights reserved.
//

import UIKit

struct ArteryModel {
    let artery: Artery
    
    let borderColor: UIColor
    var borderColorLight: UIColor {
        if artery == .pulmonary {
            return .lightDeoxygenated
        }
        return .lightOxygenated
    }
    
    let borderWidth: CGFloat
    let fillColor: UIColor = UIColor.clear
    
    var systemOrigins: [SystemConnection]? {
        switch artery {
        case .aorta:
            return [SystemConnection(locale: .rightBottom, system: .heart)]
        case .pulmonary:
            return [SystemConnection(locale: .leftTop, system: .heart)]
        default:
            return nil
        }
    }
    
    var systemTermini: [SystemConnection]? {
        switch artery {
        case .aorta:
            return [
                SystemConnection(locale: .rightBottom, system: .head),
                SystemConnection(locale: .topRight, system: .rightLeg)
            ]
        case .carotid:
            return [
                SystemConnection(locale: .rightBottom, system: .head)
            ]
        case .celiac:
            return [
                SystemConnection(locale: .topRight, system: .gut)
            ]
        case .gonadal:
            return [
                SystemConnection(locale: .rightTop, system: .lowerBody)
            ]
        case .hepatic:
            return [
                SystemConnection(locale: .topRight, system: .liver)
            ]
        case .iliac:
            return [
                SystemConnection(locale: .topRight, system: .leftLeg),
                SystemConnection(locale: .topRight, system: .rightLeg)
            ]
        case .pulmonary:
            return [
                SystemConnection(locale: .topLeft, system: .leftLung),
                SystemConnection(locale: .topLeft, system: .rightLung)
            ]
        case .renal:
            return [
                SystemConnection(locale: .topRight, system: .leftKidney),
                SystemConnection(locale: .topRight, system: .rightKidney)
            ]
        case .subclavian:
            return [
                SystemConnection(locale: .topRight, system: .rightArm),
                SystemConnection(locale: .topRight, system: .leftArm)
            ]
        }
    }
}

// MARK: - Custom initializer

extension ArteryModel {
    init(artery: Artery, borderWidth: CGFloat = 3, isHighlighted: Bool = false) {
        self.artery = artery
        if artery == .pulmonary {
            if isHighlighted {
                borderColor = .lightDeoxygenated
            } else {
                borderColor = .deoxygenated
            }
        } else {
            if isHighlighted {
                borderColor = .lightOxygenated
            } else {
                borderColor = .oxygenated
            }
        }
        self.borderWidth = borderWidth
    }
}
