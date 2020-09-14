//
//  UIViewController+Parenting.swift
//  ThreeOneOne
//
//  Created by Kaden, Joshua on 3/9/16.
//  Copyright © 2016 NYC DoITT. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func adoptChildViewController(_ childController: UIViewController, targetView: UIView? = nil) {
        self.addChild(childController)
        if let _ = targetView {
            targetView?.addSubview(childController.view)
        } else {
            self.view.addSubview(childController.view)
        }
        childController.didMove(toParent: self)
    }
    
    func leaveParentViewController() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
}
