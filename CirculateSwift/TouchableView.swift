//
//  TouchableView.swift
//  CirculateSwift
//
//  Created by Joshua Kaden on 6/28/17.
//  Copyright © 2017 Chadford Software. All rights reserved.
//

import UIKit

protocol TouchableViewDelegate: class {
    func didTouch(touchableView: TouchableView)
}

class TouchableView: UIView {
    weak var delegate: TouchableViewDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.didTouch(touchableView: self)
    }
}
