//
//  UIView+ContainsPoint.swift
//  CirculateSwift
//
//  Created by Joshua Kaden on 7/22/17.
//  Copyright © 2017 Chadford Software. All rights reserved.
//

import UIKit

extension UIView {
    func containsPoint(_ point: CGPoint, path: UIBezierPath, inFillArea: Bool) -> Bool {
        return containsPoints([point], path: path, inFillArea: inFillArea)
    }
    
    // From JaredH's solution on https://stackoverflow.com/questions/22691891/detecting-tap-inside-a-bezier-path
    func containsPoints(_ points: [CGPoint], path: UIBezierPath, inFillArea: Bool) -> Bool {
        UIGraphicsBeginImageContext(self.size)
        guard let context = UIGraphicsGetCurrentContext() else { return false }
        
        let pathToTest = path.cgPath
        
        var mode: CGPathDrawingMode = CGPathDrawingMode.stroke
        
        if inFillArea {
            // check if UIBezierPath uses EO fill
            if path.usesEvenOddFillRule {
                mode = CGPathDrawingMode.eoFill
            } else {
                mode = CGPathDrawingMode.fill
            }
        } // else mode == stroke
        
        context.saveGState()
        context.addPath(pathToTest)
        
        for point in points {
            if context.pathContains(point, mode: mode) {
                context.restoreGState()
                return true
            }
        }
        
        context.restoreGState()
        UIGraphicsEndImageContext()
        
        return false
    }
}
