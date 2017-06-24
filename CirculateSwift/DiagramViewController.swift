//
//  DiagramViewController.swift
//  CirculateSwift
//
//  Created by Joshua Kaden on 6/24/17.
//  Copyright © 2017 Chadford Software. All rights reserved.
//

import UIKit

final class DiagramViewController: UIViewController {
    
    let rowViews: [UIView] = Array(repeatElement(UIView(), count: 8))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.gray
        
        rowViews.forEach {
            view in
            view.backgroundColor = UIColor.red
            self.view.addSubview(view)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let rowSize = CGSize(width: view.width / 3, height: view.height / 14)
        let paddingSize = CGSize(width: rowSize.width / 5, height: rowSize.height / 2)
        
        for index in 0...8 {
            
        }
    }
}
