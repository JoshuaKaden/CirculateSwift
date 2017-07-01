//
//  ArteryViewController.swift
//  CirculateSwift
//
//  Created by Joshua Kaden on 6/30/17.
//  Copyright © 2017 Chadford Software. All rights reserved.
//

import UIKit

protocol ArteryViewControllerDataSource: class {
    var paddingSize: CGSize { get }
    func findRect(system: System) -> CGRect
}

final class ArteryViewController: UIViewController {
    weak var dataSource: ArteryViewControllerDataSource?
    let viewModel: ArteryViewModel
    
    init(artery: Artery) {
        self.viewModel = ArteryViewModel(artery: artery)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ArteryView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        if let arteryView = view as? ArteryView {
            arteryView.dataSource = self
        }
    }
}

extension ArteryViewController: ArteryViewDataSource {
    var paddingSize: CGSize { return dataSource?.paddingSize ?? CGSize.zero }
    
    func findRect(system: System) -> CGRect {
        return dataSource?.findRect(system: system) ?? CGRect.zero
    }
}
