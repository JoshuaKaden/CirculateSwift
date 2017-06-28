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
    private let view: UIView
    
    init(view: UIView) {
        self.view = view
    }
    
    func start() {
        /*
 CGFloat t_duration = kAnimationDuration;
 
 // Heart
 // Pulse animation.
 CABasicAnimation *t_pulseAnimation1 = ({
 CABasicAnimation *t_animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
 t_animation.fromValue = [NSNumber numberWithFloat:0.0f];
 t_animation.toValue = [NSNumber numberWithFloat:1.0f];
 t_animation.fillMode = kCAFillModeBackwards;
 t_animation;
 });
 
 CABasicAnimation *t_pulseAnimation2 = ({
 CABasicAnimation *t_animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
 t_animation.fromValue = [NSNumber numberWithFloat:1.0f];
 t_animation.toValue = [NSNumber numberWithFloat:0.0f];
 t_animation;
 });
 
 CAAnimationGroup *t_group = [CAAnimationGroup animation];
 t_group.repeatCount = HUGE_VALF;
 //t_group.delegate = self;
 t_group.duration = t_duration;
 t_group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
 t_group.animations = @[t_pulseAnimation1, t_pulseAnimation2];
 
 CAShapeLayer *t_layer = [self layerForSystem:JSKSystemHeart];
 UIColor *t_strokeColor = [UIColor clearColor];
 UIColor *t_fillColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.4];
 t_layer.strokeColor = t_strokeColor.CGColor;
 t_layer.fillColor = t_fillColor.CGColor;
 t_layer.opacity = 0.0;
 [t_layer addAnimation:t_group forKey:@"pulse"];
 [_floorLayer addSublayer:t_layer];
*/
    }
    
    func stop() {
        
    }
}
