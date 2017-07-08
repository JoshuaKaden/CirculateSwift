//
//  Artery.swift
//  CirculateSwift
//
//  Created by Joshua Kaden on 6/30/17.
//  Copyright © 2017 Chadford Software. All rights reserved.
//

import Foundation

enum Artery: CustomStringConvertible {
    case pulmonary, aorta, carotid, subclavian, celiac, hepatic, renal, gonadal, iliac
    
    var description: String {
        switch self {
        case .aorta:
            return NSLocalizedString("Aorta", comment: "")
        case .carotid:
            return NSLocalizedString("Carotid Arteries", comment: "")
        case .celiac:
            return NSLocalizedString("Celiac Artery", comment: "")
        case .gonadal:
            return NSLocalizedString("Gonadal Arteries", comment: "")
        case .hepatic:
            return NSLocalizedString("Hepatic Artery", comment: "")
        case .iliac:
            return NSLocalizedString("Iliac Arteries", comment: "")
        case .pulmonary:
            return NSLocalizedString("Pulmonary Artery", comment: "")
        case .renal:
            return NSLocalizedString("Renal Arteries", comment: "")
        case .subclavian:
            return NSLocalizedString("Subclavian Arteries", comment: "")
        }
    }
    
    var title: String { return String(describing: self) }
}
