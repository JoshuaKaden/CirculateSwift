//
//  VeinView.swift
//  CirculateSwift
//
//  Created by Joshua Kaden on 7/9/17.
//  Copyright © 2017 Chadford Software. All rights reserved.
//

import UIKit

protocol VeinViewDataSource: class {
    var aortaX: CGFloat { get }
    var venaCavaX: CGFloat { get }
    var paddingSize: CGSize { get }
    func findRect(system: System) -> CGRect
}

final class VeinView: UIView {
    weak var dataSource: VeinViewDataSource?
    let viewModel: VeinViewModel
    
    init(viewModel: VeinViewModel) {
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
        
        let originSystem = viewModel.originSystem
        let oFrame = dataSource.findRect(system: originSystem.system)
        
        let oPoint1: CGPoint
        let oPoint2: CGPoint
        switch originSystem.locale {
        case .bottom:
            oPoint1 = CGPoint(x: oFrame.origin.x + (oFrame.width / 2), y: oFrame.origin.y + oFrame.height)
            oPoint2 = CGPoint(x: oPoint1.x, y: oPoint1.y + halfPaddingHeight)
        case .bottomLeft:
            oPoint1 = CGPoint(x: oFrame.origin.x, y: oFrame.origin.y + oFrame.height)
            oPoint2 = CGPoint(x: oPoint1.x, y: oPoint1.y + halfPaddingHeight)
        case .bottomRight:
            oPoint1 = CGPoint(x: oFrame.origin.x + oFrame.width, y: oFrame.origin.y + oFrame.height)
            oPoint2 = CGPoint(x: oPoint1.x, y: oPoint1.y + halfPaddingHeight)
        case .left:
            oPoint1 = CGPoint(x: oFrame.origin.x, y: oFrame.origin.y + (oFrame.height / 2))
            oPoint2 = CGPoint(x: oPoint1.x - paddingSize.width, y: oPoint1.y)
        case .leftBottom:
            oPoint1 = CGPoint(x: oFrame.origin.x, y: oFrame.origin.y + oFrame.height)
            oPoint2 = CGPoint(x: oPoint1.x - paddingSize.width, y: oPoint1.y)
        case .leftTop:
            oPoint1 = CGPoint(x: oFrame.origin.x, y: oFrame.origin.y)
            oPoint2 = CGPoint(x: oPoint1.x - paddingSize.width, y: oPoint1.y)
        case .right:
            oPoint1 = CGPoint(x: oFrame.origin.x + oFrame.width, y: oFrame.origin.y + (oFrame.height / 2))
            oPoint2 = CGPoint(x: oPoint1.x + paddingSize.width, y: oPoint1.y)
        case .rightBottom:
            oPoint1 = CGPoint(x: oFrame.origin.x + oFrame.width, y: oFrame.origin.y + oFrame.height)
            oPoint2 = CGPoint(x: oPoint1.x + paddingSize.width, y: oPoint1.y)
        case .rightTop:
            oPoint1 = CGPoint(x: oFrame.origin.x + oFrame.width, y: oFrame.origin.y)
            oPoint2 = CGPoint(x: oPoint1.x + paddingSize.width, y: oPoint1.y)
        case .top:
            oPoint1 = CGPoint(x: oFrame.origin.x + (oFrame.width / 2), y: oFrame.origin.y)
            oPoint2 = CGPoint(x: oPoint1.x, y: oPoint1.y - halfPaddingHeight)
        case .topLeft:
            oPoint1 = CGPoint(x: oFrame.origin.x, y: oFrame.origin.y)
            oPoint2 = CGPoint(x: oPoint1.x, y: oPoint1.y - halfPaddingHeight)
        case .topRight:
            oPoint1 = CGPoint(x: oFrame.origin.x + oFrame.width, y: oFrame.origin.y)
            oPoint2 = CGPoint(x: oPoint1.x, y: oPoint1.y - halfPaddingHeight)
        }
        
        switch viewModel.vein {
        case .inferiorVenaCava, .superiorVenaCava:
            path.move(to: oPoint2)
        default:
            path.move(to: oPoint1)
            path.addLine(to: oPoint2)
        }
        
        switch viewModel.vein {
        case .pulmonary:
            path.addLine(to: CGPoint(x: dataSource.aortaX - paddingSize.width, y: path.currentPoint.y))
        case .hepaticPortal:
            break
        default:
            path.addLine(to: CGPoint(x: dataSource.venaCavaX, y: path.currentPoint.y))
        }
        
        guard let terminusSystem = viewModel.terminusSystem else {
            return path
        }
        
        let tFrame = dataSource.findRect(system: terminusSystem.system)
        
        let targetY: CGFloat
        switch terminusSystem.locale {
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
        
        path.addLine(to: CGPoint(x: path.currentPoint.x, y: targetY))
        
        let targetX: CGFloat
        switch terminusSystem.locale {
        case .bottom, .top:
            targetX = tFrame.origin.x + (tFrame.width / 2)
        case .bottomLeft, .left, .leftBottom, .leftTop, .topLeft:
            targetX = tFrame.origin.x
        case .bottomRight, .right, .rightBottom, .rightTop, .topRight:
            targetX = tFrame.maxX
        }
        
        path.addLine(to: CGPoint(x: targetX, y: path.currentPoint.y))
        
        return path
    }
}
