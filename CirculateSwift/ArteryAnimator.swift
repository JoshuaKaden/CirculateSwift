//
//  ArteryAnimator.swift
//  CirculateSwift
//
//  Created by Joshua Kaden on 7/9/17.
//  Copyright © 2017 Chadford Software. All rights reserved.
//

import UIKit

final class ArteryAnimator {
    
    private var floorLayer: CALayer?
    
    func start(view: ArteryView) {
        stop()
        
        let color: UIColor
        switch view.viewModel.artery {
        case .pulmonary:
            color = .lightDeoxygenated
        default:
            color = .lightOxygenated
        }
        
        let floorLayer = CALayer()
        floorLayer.frame = view.bounds
        view.layer.addSublayer(floorLayer)
        self.floorLayer = floorLayer
        
        let duration = 2.0
        
        let pulse1 = CABasicAnimation(keyPath: "strokeEnd")
        pulse1.fromValue = 0.0
        pulse1.toValue = 1.0
        
        let pulse2 = CABasicAnimation(keyPath: "opacity")
        pulse2.fromValue = 1
        pulse2.toValue = 0.5

        let group = CAAnimationGroup()
        group.repeatCount = HUGE
        group.duration = duration
        group.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        group.animations = [pulse1, pulse2]
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = view.buildPath(lineWidth: view.viewModel.borderWidth).cgPath
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.add(group, forKey: "pulse \(view.viewModel.artery)")
        
        floorLayer.addSublayer(shapeLayer)
    }
    
    func stop() {
        floorLayer?.removeAllAnimations()
        floorLayer?.removeFromSuperlayer()
        floorLayer = nil
    }
}
