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
        
        let oFrame = dataSource.findRect(system: viewModel.originSystem.system)
        switch viewModel.originSystem.locale {
        case .bottom:
            path.move(to: CGPoint(x: oFrame.origin.x + (oFrame.width / 2), y: oFrame.origin.y + oFrame.height))
            path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y + halfPaddingHeight))
        case .bottomLeft:
            path.move(to: CGPoint(x: oFrame.origin.x, y: oFrame.origin.y + oFrame.height))
            path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y + halfPaddingHeight))
        case .bottomRight:
            path.move(to: CGPoint(x: oFrame.origin.x + oFrame.width, y: oFrame.origin.y + oFrame.height))
            path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y + halfPaddingHeight))
        case .left:
            path.move(to: CGPoint(x: oFrame.origin.x, y: oFrame.origin.y + (oFrame.height / 2)))
            path.addLine(to: CGPoint(x: path.currentPoint.x - paddingSize.width, y: path.currentPoint.y))
        case .leftBottom:
            path.move(to: CGPoint(x: oFrame.origin.x, y: oFrame.origin.y + oFrame.height))
            path.addLine(to: CGPoint(x: path.currentPoint.x - paddingSize.width, y: path.currentPoint.y))
        case .leftTop:
            path.move(to: CGPoint(x: oFrame.origin.x, y: oFrame.origin.y))
            path.addLine(to: CGPoint(x: path.currentPoint.x - paddingSize.width, y: path.currentPoint.y))
        case .right:
            path.move(to: CGPoint(x: oFrame.origin.x + oFrame.width, y: oFrame.origin.y + (oFrame.height / 2)))
            path.addLine(to: CGPoint(x: path.currentPoint.x + paddingSize.width, y: path.currentPoint.y))
        case .rightBottom:
            path.move(to: CGPoint(x: oFrame.origin.x + oFrame.width, y: oFrame.origin.y + oFrame.height))
            path.addLine(to: CGPoint(x: path.currentPoint.x + paddingSize.width, y: path.currentPoint.y))
        case .rightTop:
            path.move(to: CGPoint(x: oFrame.origin.x + oFrame.width, y: oFrame.origin.y))
            path.addLine(to: CGPoint(x: path.currentPoint.x + paddingSize.width, y: path.currentPoint.y))
        case .top:
            path.move(to: CGPoint(x: oFrame.origin.x + (oFrame.width / 2), y: oFrame.origin.y))
            path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y - halfPaddingHeight))
        case .topLeft:
            path.move(to: CGPoint(x: oFrame.origin.x, y: oFrame.origin.y))
            path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y - halfPaddingHeight))
        case .topRight:
            path.move(to: CGPoint(x: oFrame.origin.x + oFrame.width, y: oFrame.origin.y))
            path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y - halfPaddingHeight))
        }
        
        let tFrame = dataSource.findRect(system: viewModel.terminusSystem.system)
        
        let targetY: CGFloat
        switch viewModel.terminusSystem.locale {
        case .bottom, .bottomLeft, .bottomRight:
            targetY = tFrame.maxY + halfPaddingHeight
        case .left, .right:
            targetY = tFrame.midY
        case .leftBottom, .rightBottom:
            targetY = tFrame.maxY
        case .leftTop, .rightTop:
            targetY = tFrame.origin.y
        case .top, .topLeft, .topRight:
            targetY = tFrame.origin.y - halfPaddingHeight
        }
        
        let delta: CGFloat
        if targetY < path.currentPoint.y {
            delta = (path.currentPoint.y - targetY) * -1
        } else {
            delta = targetY - path.currentPoint.y
        }
        
        path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y + delta))
        
        switch viewModel.terminusSystem.locale {
        case .bottom:
            path.addLine(to: CGPoint(x: tFrame.midX, y: path.currentPoint.y))
            path.addLine(to: CGPoint(x: path.currentPoint.x, y: tFrame.maxY))
        case .bottomLeft:
            path.addLine(to: CGPoint(x: tFrame.origin.x, y: path.currentPoint.y))
            path.addLine(to: CGPoint(x: path.currentPoint.x, y: tFrame.maxY))
        case .bottomRight:
            path.addLine(to: CGPoint(x: tFrame.maxX, y: path.currentPoint.y))
            path.addLine(to: CGPoint(x: path.currentPoint.x, y: tFrame.maxY))
        case .left, .leftBottom, .leftTop:
            path.addLine(to: CGPoint(x: tFrame.origin.x, y: path.currentPoint.y))
        case .right, .rightBottom, .rightTop:
            path.addLine(to: CGPoint(x: tFrame.origin.x, y: path.currentPoint.y))
        case .top:
            path.addLine(to: CGPoint(x: tFrame.midX, y: path.currentPoint.y))
            path.addLine(to: CGPoint(x: path.currentPoint.x, y: tFrame.origin.y))
        case .topLeft:
            path.addLine(to: CGPoint(x: tFrame.origin.x, y: path.currentPoint.y))
            path.addLine(to: CGPoint(x: path.currentPoint.x, y: tFrame.origin.y))
        case .topRight:
            path.addLine(to: CGPoint(x: tFrame.maxX, y: path.currentPoint.y))
            path.addLine(to: CGPoint(x: path.currentPoint.x, y: tFrame.origin.y))
        }
        
        return path
    }
}
