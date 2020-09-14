//
//  SystemViewController.swift
//  CirculateSwift
//
//  Created by Joshua Kaden on 6/26/17.
//  Copyright © 2017 Chadford Software. All rights reserved.
//

import UIKit

final class SystemViewController: UIViewController {
    let titleLabel = UILabel()
    let viewModel: SystemViewModel
    
    init(system: System) {
        viewModel = SystemViewModel(system: system)
        super.init(nibName: nil, bundle: nil)
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.font = UIFont.appFont(size: 8, weight: .regular)
        titleLabel.text = viewModel.system.title
        titleLabel.textColor = .white
        view.addSubview(titleLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleLabel.sizeToFit()
        titleLabel.x = 4
        titleLabel.y = 4
        view.bringSubviewToFront(titleLabel)
    }
}
