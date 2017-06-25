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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.gray
        
        rowViews.forEach {
            view in
            view.backgroundColor = UIColor.red
            self.containerView.addSubview(view)
        }
        
        view.addSubview(containerView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layoutRowViews()
        
    }
    
    private func layoutRowViews() {
        let rowSize = CGSize(width: view.width / 2, height: view.height / 15)
        let paddingSize = CGSize(width: rowSize.width / 5, height: rowSize.height / 1.7)
        
        var lastMaxY = CGFloat(0)
        for index in 0...7 {
            let view = rowViews[index]
            view.size = rowSize
            
            view.y = lastMaxY
            switch index {
            case 2, 5:
                // room for top and bottom connections
                view.y += paddingSize.height
            case 3, 4:
                // room for top or bottom connections
                view.y += paddingSize.height * 0.5
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
