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
    
    var borderColor: UIColor {
        if artery == .pulmonary {
            return .deoxygenated
        }
        return .oxygenated
    }
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
        case .pulmonary:
            return [
                SystemConnection(locale: .topLeft, system: .leftLung),
                SystemConnection(locale: .topLeft, system: .rightLung)
            ]
        default:
            return nil
        }
    }
}
