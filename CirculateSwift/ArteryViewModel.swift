//
//  ArteryViewModel.swift
//  CirculateSwift
//
//  Created by Joshua Kaden on 6/30/17.
//  Copyright © 2017 Chadford Software. All rights reserved.
//

import UIKit

struct ArteryViewModel {
    let artery: Artery
    
    var borderColor: UIColor {
        if artery == .pulmonary {
            return .deoxygenated
        }
        return .oxygenated
    }
    let fillColor: UIColor = UIColor.clear
    
    var systemOrigin: SystemConnection? {
        switch artery {
        case .aorta:
            return SystemConnection(locale: .rightBottom, system: .heart)
        case .pulmonary:
            return SystemConnection(locale: .leftTop, system: .heart)
        default:
            return nil
        }
    }
    
    var systemTermini: [SystemConnection]? {
        switch artery {
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
