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
        let string: String
        switch self {
        case .gut:
            string = "Gut"
        case .head:
            string = "Head"
        case .heart:
            string = "Heart"
        case .leftArm:
            string = "Left Arm"
        case .leftKidney:
            string = "Left Kidney"
        case .leftLeg:
            string = "Left Leg"
        case .leftLung:
            string = "Left Lung"
        case .liver:
            string = "Liver"
        case .lowerBody:
            string = "Lower Body"
        case .rightArm:
            string = "Right Arm"
        case .rightKidney:
            string = "Right Kidney"
        case .rightLeg:
            string = "Right Leg"
        case .rightLung:
            string = "Right Lung"
        }
        return NSLocalizedString(string, comment: "")
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
        let string: String
        switch self {
        case .gut:
            string = "Gut"
        case .head:
            string = "Head"
        case .heart:
            string = "Heart"
        case .leftArm, .rightArm:
            string = "Arm"
        case .leftKidney, .rightKidney:
            string = "Kidney"
        case .leftLeg, .rightLeg:
            string = "Leg"
        case .leftLung, .rightLung:
            string = "Lung"
        case .liver:
            string = "Liver"
        case .lowerBody:
            string = "Lower Body"
        }
        return NSLocalizedString(string, comment: "")
    }
    
    /*
 JSKSystemHeart,
 JSKSystemPulmonaryArtery,
 JSKSystemLeftLung,
 JSKSystemRightLung,
 JSKSystemPulmonaryVein,
 JSKSystemAorta,
 JSKSystemCarotidArteries,
 JSKSystemHead,
 JSKSystemJugularVeins,
 JSKSystemSuperiorVenaCava,
 JSKSystemSubclavianArteries,
 JSKSystemRightArm,
 JSKSystemLeftArm,
 JSKSystemSubclavianVeins,
 JSKSystemCeliacArtery,
 JSKSystemGut,
 JSKSystemHepaticPortalVein,
 JSKSystemHepaticArtery,
 JSKSystemLiver,
 JSKSystemHepaticVeins,
 JSKSystemInferiorVenaCava,
 JSKSystemRenalArteries,
 JSKSystemRightKidney,
 JSKSystemLeftKidney,
 JSKSystemRenalVeins,
 JSKSystemGonadalArteries,
 JSKSystemLowerBody,
 JSKSystemGonadalVeins,
 JSKSystemIliacArtieries,
 JSKSystemRightLeg,
 JSKSystemLeftLeg,
 JSKSystemIliacVeins,
*/
}
