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
    let viewModel: ArteryViewModel
    
    init(viewModel: ArteryViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let path = buildPath()
        viewModel.borderColor.setStroke()
        viewModel.fillColor.setFill()
        path.fill()
        path.stroke()
    }
    
    func buildPath() -> UIBezierPath {
        let path = UIBezierPath()
        guard let dataSource = dataSource else { return path }
        
        let paddingSize = dataSource.paddingSize
        let halfPaddingHeight = paddingSize.height / 2

        path.lineJoinStyle = .round
        path.lineWidth = 3.0
        
        if let systemOrigin = viewModel.systemOrigin {
            let frame = dataSource.findRect(system: systemOrigin.system)
            switch systemOrigin.locale {
            case .bottom:
                path.move(to: CGPoint(x: frame.origin.x + (frame.width / 2), y: frame.origin.y + frame.height))
                path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y + halfPaddingHeight))
            case .bottomLeft:
                path.move(to: CGPoint(x: frame.origin.x, y: frame.origin.y + frame.height))
                path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y + halfPaddingHeight))
            case .bottomRight:
                path.move(to: CGPoint(x: frame.origin.x + frame.width, y: frame.origin.y + frame.height))
                path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y + halfPaddingHeight))
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
                path.addLine(to: CGPoint(x: path.currentPoint.x + paddingSize.width, y: path.currentPoint.y))
            case .rightBottom:
                path.move(to: CGPoint(x: frame.origin.x + frame.width, y: frame.origin.y + frame.height))
                path.addLine(to: CGPoint(x: path.currentPoint.x + paddingSize.width, y: path.currentPoint.y))
            case .rightTop:
                path.move(to: CGPoint(x: frame.origin.x + frame.width, y: frame.origin.y))
                path.addLine(to: CGPoint(x: path.currentPoint.x + paddingSize.width, y: path.currentPoint.y))
            case .top:
                path.move(to: CGPoint(x: frame.origin.x + (frame.width / 2), y: frame.origin.y))
                path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y - halfPaddingHeight))
            case .topLeft:
                path.move(to: CGPoint(x: frame.origin.x, y: frame.origin.y))
                path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y - halfPaddingHeight))
            case .topRight:
                path.move(to: CGPoint(x: frame.origin.x + frame.width, y: frame.origin.y))
                path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y - halfPaddingHeight))
            }
        }
        
        if let systemTermini = viewModel.systemTermini, let firstTerminus = systemTermini.first {
            let frame = dataSource.findRect(system: firstTerminus.system)
            
            let targetY: CGFloat
            switch firstTerminus.locale {
            case .bottom, .bottomLeft, .bottomRight:
                targetY = frame.maxY + halfPaddingHeight
            case .left, .right:
                targetY = frame.midY
            case .leftBottom, .rightBottom:
                targetY = frame.maxY
            case .leftTop, .rightTop:
                targetY = frame.origin.y
            case .top, .topLeft, .topRight:
                targetY = frame.origin.y - halfPaddingHeight
            }
            
            let delta: CGFloat
            if targetY < path.currentPoint.y {
                delta = (path.currentPoint.y - targetY) * -1
            } else {
                delta = targetY - path.currentPoint.y
            }
            
            path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y + delta))
            
            switch firstTerminus.locale {
            case .bottom:
                path.addLine(to: CGPoint(x: frame.midX, y: path.currentPoint.y))
                path.addLine(to: CGPoint(x: path.currentPoint.x, y: frame.maxY))
            case .bottomLeft:
                path.addLine(to: CGPoint(x: frame.origin.x, y: path.currentPoint.y))
                path.addLine(to: CGPoint(x: path.currentPoint.x, y: frame.maxY))
            case .bottomRight:
                path.addLine(to: CGPoint(x: frame.maxX, y: path.currentPoint.y))
                path.addLine(to: CGPoint(x: path.currentPoint.x, y: frame.maxY))
            case .left, .leftBottom, .leftTop:
                path.addLine(to: CGPoint(x: frame.origin.x, y: path.currentPoint.y))
            case .right, .rightBottom, .rightTop:
                path.addLine(to: CGPoint(x: frame.origin.x, y: path.currentPoint.y))
            case .top:
                path.addLine(to: CGPoint(x: frame.midX, y: path.currentPoint.y))
                path.addLine(to: CGPoint(x: path.currentPoint.x, y: frame.origin.y))
            case .topLeft:
                path.addLine(to: CGPoint(x: frame.origin.x, y: path.currentPoint.y))
                path.addLine(to: CGPoint(x: path.currentPoint.x, y: frame.origin.y))
            case .topRight:
                path.addLine(to: CGPoint(x: frame.maxX, y: path.currentPoint.y))
                path.addLine(to: CGPoint(x: path.currentPoint.x, y: frame.origin.y))
            }
        }
        
        return path
    }
}
