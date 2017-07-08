//
//  Vein.swift
//  CirculateSwift
//
//  Created by Joshua Kaden on 6/30/17.
//  Copyright © 2017 Chadford Software. All rights reserved.
//

import Foundation

enum Vein: CustomStringConvertible {
    case pulmonary, superiorVenaCava, subclavian, hepaticPortal, hepatic, inferiorVenaCava, renal, gonadal, iliac
    
    var description: String {
        switch self {
        case .gonadal:
            return NSLocalizedString("Gonadal Veins", comment: "")
        case .hepatic:
            return NSLocalizedString("Hepatic Veins", comment: "")
        case .hepaticPortal:
            return NSLocalizedString("Hepatic Portal Vein", comment: "")
        case .iliac:
            return NSLocalizedString("Iliac Veins", comment: "")
        case .inferiorVenaCava:
            return NSLocalizedString("Inferior Vena Cava", comment: "")
        case .pulmonary:
            return NSLocalizedString("Pulmonary Vein", comment: "")
        case .renal:
            return NSLocalizedString("Renal Veins", comment: "")
        case .subclavian:
            return NSLocalizedString("Subclavian Veins", comment: "")
        case .superiorVenaCava:
            return NSLocalizedString("Superior Vena Cava", comment: "")
        }
    }
    
    var title: String { return String(describing: self) }
}
