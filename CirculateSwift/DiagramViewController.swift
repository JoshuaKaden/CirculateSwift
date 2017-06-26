//
//  DiagramViewController.swift
//  CirculateSwift
//
//  Created by Joshua Kaden on 6/24/17.
//  Copyright © 2017 Chadford Software. All rights reserved.
//

import UIKit

final class DiagramViewController: UIViewController {
    
    let containerView = UIView()
    let rowViews = [UIView(), UIView(), UIView(), UIView(), UIView(), UIView(), UIView(), UIView()]
    let systemViewControllers: [SystemViewController] = [
        SystemViewController(viewModel: SystemViewModel(system: .head)),
        SystemViewController(viewModel: SystemViewModel(system: .leftArm))
    ]
    
    deinit {
        systemViewControllers.forEach { $0.leaveParentViewController() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.gray
        
        rowViews.forEach {
            view in
            view.backgroundColor = UIColor.red
            self.containerView.addSubview(view)
        }
        
        view.addSubview(containerView)
        
        systemViewControllers.forEach {
            vc in
            let targetView = self.rowViews[vc.viewModel.system.systemRow.rawValue]
            self.adoptChildViewController(vc, targetView: targetView)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layoutRowViews()
        
        systemViewControllers.forEach {
            vc in
            let systemRow = vc.viewModel.system.systemRow
            let rowView = self.rowViews[systemRow.rawValue]
            if systemRow.isTwin {
                vc.view.size = CGSize(width: rowView.width / 2, height: rowView.height)
            } else {
                vc.view.size = rowView.size
            }
        }
    }
    
    private func layoutRowViews() {
        let rowSize = CGSize(width: view.width / 2, height: view.height / 15)
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
