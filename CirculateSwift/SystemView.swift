//
//  SystemView.swift
//  CirculateSwift
//
//  Created by Joshua Kaden on 6/26/17.
//  Copyright © 2017 Chadford Software. All rights reserved.
//

import UIKit

final class SystemView: UIView {
    private var drawingLayer: CAShapeLayer?
    private let viewModel: SystemViewModel
    
    init(viewModel: SystemViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        self.drawingLayer?.removeFromSuperlayer()
        
        let path = buildPath()
        
        let sublayer = CAShapeLayer()
        sublayer.path = path.cgPath
        sublayer.strokeColor = viewModel.borderColor.cgColor
        sublayer.fillColor = viewModel.fillColor.cgColor
        
        layer.addSublayer(sublayer)
        self.drawingLayer = sublayer
    }
    
    func buildPath() -> UIBezierPath {
        let path = UIBezierPath(rect: bounds)
        path.lineWidth = 1.0
        
        if viewModel.system == .heart {
            path.move(to: CGPoint(x: width / 2, y: 0))
            path.addLine(to: CGPoint(x: width / 2, y: height))
        }
        
        return path
    }
}
