//
//  System.swift
//  CirculateSwift
//
//  Created by Joshua Kaden on 6/25/17.
//  Copyright © 2017 Chadford Software. All rights reserved.
//

import Foundation

enum System: CustomStringConvertible {
    
    case gut, head, heart, leftArm, leftKidney, leftLeg, leftLung, liver, lowerBody, rightArm, rightKidney, rightLeg, rightLung
    
    var description: String {
        switch self {
        case .gut:
            return NSLocalizedString("Gut", comment: "")
        case .head:
            return NSLocalizedString("Head", comment: "")
        case .heart:
            return NSLocalizedString("Heart", comment: "")
        case .leftArm:
            return NSLocalizedString("Left Arm", comment: "")
        case .leftKidney:
            return NSLocalizedString("Left Kidney", comment: "")
        case .leftLeg:
            return NSLocalizedString("Left Leg", comment: "")
        case .leftLung:
            return NSLocalizedString("Left Lung", comment: "")
        case .liver:
            return NSLocalizedString("Liver", comment: "")
        case .lowerBody:
            return NSLocalizedString("Lower Body", comment: "")
        case .rightArm:
            return NSLocalizedString("Right Arm", comment: "")
        case .rightKidney:
            return NSLocalizedString("Right Kidney", comment: "")
        case .rightLeg:
            return NSLocalizedString("Right Leg", comment: "")
        case .rightLung:
            return NSLocalizedString("Right Lung", comment: "")
        }
    }
    
    var systemRow: SystemRow {
        switch self {
        case .gut, .liver:
            return .liverGut
        case .head:
            return .head
        case .heart:
            return .heart
        case .leftArm, .rightArm:
            return .arms
        case .leftKidney, .rightKidney:
            return .kidneys
        case .leftLeg, .rightLeg:
            return .legs
        case .leftLung, .rightLung:
            return .lungs
        case .lowerBody:
            return .lowerBody
        }
    }
    
    var title: String {
        switch self {
        case .gut:
            return NSLocalizedString("Gut", comment: "")
        case .head:
            return NSLocalizedString("Head", comment: "")
        case .heart:
            return NSLocalizedString("Heart", comment: "")
        case .leftArm, .rightArm:
            return NSLocalizedString("Arm", comment: "")
        case .leftKidney, .rightKidney:
            return NSLocalizedString("Kidney", comment: "")
        case .leftLeg, .rightLeg:
            return NSLocalizedString("Leg", comment: "")
        case .leftLung, .rightLung:
            return NSLocalizedString("Lung", comment: "")
        case .liver:
            return NSLocalizedString("Liver", comment: "")
        case .lowerBody:
            return NSLocalizedString("Lower Body", comment: "")
        }
    }
}
