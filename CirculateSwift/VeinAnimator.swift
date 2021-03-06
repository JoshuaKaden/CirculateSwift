//
//  VeinAnimator.swift
//  CirculateSwift
//
//  Created by Joshua Kaden on 7/19/17.
//  Copyright © 2017 Chadford Software. All rights reserved.
//

import UIKit

final class VeinAnimator {
    
    private var floorLayer: CALayer?
    
    func start(view: VeinView) {
        stop()
        
        let color1 = view.viewModel.borderColorLight
        let color2 = view.viewModel.borderColor
        
        let floorLayer = CALayer()
        floorLayer.frame = view.bounds
        view.layer.addSublayer(floorLayer)
        self.floorLayer = floorLayer
        
        let duration = 2.0
        
        let pulse1 = CABasicAnimation(keyPath: "strokeEnd")
        pulse1.fromValue = 0.0
        pulse1.toValue = 1.0
        pulse1.duration = duration
        pulse1.repeatCount = HUGE
        
        let shapeLayer1 = CAShapeLayer()
        shapeLayer1.path = view.buildPath(lineWidth: view.viewModel.borderWidth).cgPath
        shapeLayer1.strokeColor = color1.cgColor
        shapeLayer1.fillColor = UIColor.clear.cgColor
        shapeLayer1.lineWidth = 3
        shapeLayer1.lineCap = CAShapeLayerLineCap.round
        shapeLayer1.add(pulse1, forKey: "pulse1")
        
        floorLayer.addSublayer(shapeLayer1)
        
        let pulse2 = CABasicAnimation(keyPath: "strokeEnd")
        pulse2.fromValue = 0.0
        pulse2.toValue = 1.0
        pulse2.beginTime = CACurrentMediaTime() + 0.2
        pulse2.duration = duration
        pulse2.repeatCount = HUGE
        
        let shapeLayer2 = CAShapeLayer()
        shapeLayer2.path = view.buildPath(lineWidth: view.viewModel.borderWidth).cgPath
        shapeLayer2.strokeColor = color2.cgColor
        shapeLayer2.fillColor = UIColor.clear.cgColor
        shapeLayer2.lineWidth = 3
        shapeLayer2.lineCap = CAShapeLayerLineCap.round
        shapeLayer2.add(pulse2, forKey: "pulse2")
        
        floorLayer.addSublayer(shapeLayer2)
    }
    
    func stop() {
        guard let floorLayer = floorLayer else { return }
        floorLayer.sublayers?.forEach {
            sublayer in
            sublayer.removeAllAnimations()
            sublayer.removeFromSuperlayer()
        }
        floorLayer.removeAllAnimations()
        floorLayer.removeFromSuperlayer()
        self.floorLayer = nil
    }
}
