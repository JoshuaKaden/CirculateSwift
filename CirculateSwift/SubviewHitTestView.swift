//
//  SubviewHitTestView.swift
//  CirculateSwift
//
//  Created by Joshua Kaden on 7/20/17.
//  Copyright © 2017 Chadford Software. All rights reserved.
//

import UIKit



final class SubviewHitTestView: UIView {
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !isUserInteractionEnabled || isHidden || alpha <= 0.01 {
            return nil
        }
        
        if !self.point(inside: point, with: event) {
            return nil
        }
        
        for subview in subviews {
            let convertedPoint = subview.convert(point, from: self)
            if let hitView = subview.hitTest(convertedPoint, with: event) {
                return hitView
            }
        }
        
        return nil
    }
}
