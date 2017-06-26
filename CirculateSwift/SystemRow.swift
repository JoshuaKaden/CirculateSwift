//
//  SystemRow.swift
//  CirculateSwift
//
//  Created by Joshua Kaden on 6/26/17.
//  Copyright © 2017 Chadford Software. All rights reserved.
//

import Foundation

enum SystemRow: Int {
    case head = 0, arms = 1, lungs = 2, heart = 3, liverGut = 4, kidneys = 5, lowerBody = 6, legs = 7
    
    var isTwin: Bool {
        switch self {
        case .arms, .lungs, .liverGut, .kidneys, .legs:
            return true
        default:
            return false
        }
    }
}
