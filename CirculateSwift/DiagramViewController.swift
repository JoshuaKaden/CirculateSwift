//
//  DiagramViewController.swift
//  CirculateSwift
//
//  Created by Joshua Kaden on 6/24/17.
//  Copyright © 2017 Chadford Software. All rights reserved.
//

import UIKit

final class DiagramViewController: UIViewController {
    
    private let containerView = UIView()
    private var rowSize: CGSize { return CGSize(width: view.width / 2, height: view.height / 15) }
    private let rowViews = [UIView(), UIView(), UIView(), UIView(), UIView(), UIView(), UIView(), UIView()]
    private let systemViewControllers: [SystemViewController] = [
        SystemViewController(viewModel: SystemViewModel(system: System.gut)),
        SystemViewController(viewModel: SystemViewModel(system: System.head)),
        SystemViewController(viewModel: SystemViewModel(system: System.heart)),
        SystemViewController(viewModel: SystemViewModel(system: System.leftArm)),
        SystemViewController(viewModel: SystemViewModel(system: System.leftKidney)),
        SystemViewController(viewModel: SystemViewModel(system: System.leftLeg)),
        SystemViewController(viewModel: SystemViewModel(system: System.leftLung)),
        SystemViewController(viewModel: SystemViewModel(system: System.liver)),
        SystemViewController(viewModel: SystemViewModel(system: System.lowerBody)),
        SystemViewController(viewModel: SystemViewModel(system: System.rightArm)),
        SystemViewController(viewModel: SystemViewModel(system: System.rightKidney)),
        SystemViewController(viewModel: SystemViewModel(system: System.rightLeg)),
        SystemViewController(viewModel: SystemViewModel(system: System.rightLung))
    ]
    private var twinWidth: CGFloat { return (rowSize.width / 2) - (rowSize.width / 16) }
    
    deinit {
        systemViewControllers.forEach { $0.leaveParentViewController() }
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.gray
        
        rowViews.forEach {
            view in
            self.containerView.addSubview(view)
        }
        
        view.addSubview(containerView)
        
        systemViewControllers.forEach {
            vc in
            let targetView = self.rowViews[vc.viewModel.system.systemRow.rawValue]
            self.adoptChildViewController(vc, targetView: targetView)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeOrientation(_:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    func delay(_ delay: Double, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    func didChangeOrientation(_ sender: Notification) {
        systemViewControllers.forEach {
            $0.view.setNeedsDisplay()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layoutRowViews()
        
        systemViewControllers.forEach {
            vc in
            let system = vc.viewModel.system
            let systemRow = system.systemRow
            let rowView = self.rowViews[systemRow.rawValue]
            if systemRow.isTwin {
                vc.view.size = CGSize(width: twinWidth, height: rowView.height)
                switch system {
                case .gut, .rightArm, .rightKidney, .rightLeg, .rightLung:
                    vc.view.x = rowView.width - twinWidth
                default:
                    // no op
                    break
                }
            } else {
                vc.view.size = rowView.size
            }
        }
    }
    
    private func layoutRowViews() {
        let paddingSize = CGSize(width: rowSize.width / 5, height: rowSize.height / 1.7)
        
        var lastMaxY = CGFloat(0)
        for index in 0...7 {
            let systemRow = SystemRow(rawValue: index)!
            let view = rowViews[index]
            view.size = rowSize
            
            view.y = lastMaxY
            switch systemRow {
            case .lungs, .kidneys:
                // room for top and bottom connections
                view.y += paddingSize.height
            default:
                // no op
                break
            }
            
            lastMaxY = view.maxY + paddingSize.height
        }
        
        guard let lastRowView = rowViews.last else { return }
        containerView.size = CGSize(width: rowSize.width, height: lastRowView.maxY)
        
        containerView.centerInSuperview()
    }
}
