//
//  SystemViewController.swift
//  CirculateSwift
//
//  Created by Joshua Kaden on 6/26/17.
//  Copyright © 2017 Chadford Software. All rights reserved.
//

import UIKit

final class SystemViewController: UIViewController {
    let viewModel: SystemViewModel
    
    init(viewModel: SystemViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = SystemView(viewModel: viewModel)
    }
}
