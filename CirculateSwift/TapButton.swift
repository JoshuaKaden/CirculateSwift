//
//  TapButton.swift
//  ThreeOneOne
//
//  Created by Kaden, Joshua on 10/26/15.
//  Copyright © 2015 NYC DoITT. All rights reserved.
//

import UIKit

class TapButton: UIButton {
    
    var tapAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(performTapAction), for: .touchUpInside)
    }
    
    @objc func performTapAction() {
        if let tapAction = self.tapAction {
            tapAction()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
