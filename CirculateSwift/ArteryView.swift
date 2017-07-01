//
//  ArteryView.swift
//  CirculateSwift
//
//  Created by Joshua Kaden on 6/30/17.
//  Copyright © 2017 Chadford Software. All rights reserved.
//

import UIKit

protocol ArteryViewDataSource: class {
    var paddingSize: CGSize { get }
    func findRect(system: System) -> CGRect
}

final class ArteryView: UIView {
    weak var dataSource: ArteryViewDataSource?
    private var drawingLayer: CAShapeLayer?
    let viewModel: ArteryViewModel
    
    init(viewModel: ArteryViewModel) {
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
        let path = UIBezierPath()
        guard let dataSource = dataSource else { return path }
        
        let paddingSize = dataSource.paddingSize
        path.lineWidth = 3.0
        
        if let systemOrigin = viewModel.systemOrigin {
            let frame = dataSource.findRect(system: systemOrigin.system)
            switch systemOrigin.locale {
            case .bottom:
                path.move(to: CGPoint(x: frame.origin.x + (frame.width / 2), y: frame.origin.y + frame.height))
                path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y + paddingSize.height / 2))
            case .bottomLeft:
                path.move(to: CGPoint(x: frame.origin.x, y: frame.origin.y + frame.height))
                path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y + paddingSize.height / 2))
            case .bottomRight:
                path.move(to: CGPoint(x: frame.origin.x + frame.width, y: frame.origin.y + frame.height))
                path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y + paddingSize.height / 2))
            case .left:
                path.move(to: CGPoint(x: frame.origin.x, y: frame.origin.y + (frame.height / 2)))
                path.addLine(to: CGPoint(x: path.currentPoint.x - paddingSize.width, y: path.currentPoint.y))
            case .leftBottom:
                path.move(to: CGPoint(x: frame.origin.x, y: frame.origin.y + frame.height))
                path.addLine(to: CGPoint(x: path.currentPoint.x - paddingSize.width, y: path.currentPoint.y))
            case .leftTop:
                path.move(to: CGPoint(x: frame.origin.x, y: frame.origin.y))
                path.addLine(to: CGPoint(x: path.currentPoint.x - paddingSize.width, y: path.currentPoint.y))
            case .right:
                path.move(to: CGPoint(x: frame.origin.x + frame.width, y: frame.origin.y + (frame.height / 2)))
            case .rightBottom:
                path.move(to: CGPoint(x: frame.origin.x + frame.width, y: frame.origin.y + frame.height))
            case .rightTop:
                path.move(to: CGPoint(x: frame.origin.x + frame.width, y: frame.origin.y))
            case .top:
                path.move(to: CGPoint(x: frame.origin.x + (frame.width / 2), y: frame.origin.y))
                path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y - paddingSize.height / 2))
            case .topLeft:
                path.move(to: CGPoint(x: frame.origin.x, y: frame.origin.y))
                path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y - paddingSize.height / 2))
            case .topRight:
                path.move(to: CGPoint(x: frame.origin.x + frame.width, y: frame.origin.y))
                path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y - paddingSize.height / 2))
            }
        }
        
        
        
        return path
    }
}
