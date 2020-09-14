//
//  HeartAnimator.swift
//  CirculateSwift
//
//  Created by Joshua Kaden on 6/28/17.
//  Copyright © 2017 Chadford Software. All rights reserved.
//

import UIKit

final class HeartAnimator {
    
    private var floorLayer: CALayer?
    
    func start(view: SystemView) {
        stop()
        
        let floorLayer = CALayer()
        floorLayer.frame = view.bounds
        view.layer.addSublayer(floorLayer)
        self.floorLayer = floorLayer
        
        let duration = 2.0
        
        let pulse1 = CABasicAnimation(keyPath: "opacity")
        pulse1.fromValue = 0
        pulse1.toValue = 1
        pulse1.fillMode = CAMediaTimingFillMode.backwards
        
        let pulse2 = CABasicAnimation(keyPath: "opacity")
        pulse2.fromValue = 1
        pulse2.toValue = 0
        
        let group = CAAnimationGroup()
        group.repeatCount = HUGE
        group.duration = duration
        group.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        group.animations = [pulse1, pulse2]
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = view.buildPath().cgPath
        shapeLayer.frame = floorLayer.bounds
        shapeLayer.fillColor = UIColor.init(easyRed: 1, easyGreen: 1, easyBlue: 1, alpha: 0.4).cgColor
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.opacity = 0
        shapeLayer.add(group, forKey: "pulse")
        
        floorLayer.addSublayer(shapeLayer)
    }
    
    func stop() {
        floorLayer?.removeAllAnimations()
        floorLayer?.removeFromSuperlayer()
        floorLayer = nil
    }
}
