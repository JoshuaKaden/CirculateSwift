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
    private var arteryViews: [ArteryView] = []
    weak var dataSource: ArteryViewControllerDataSource?
    let model: ArteryModel
    
    init(artery: Artery) {
        self.model = ArteryModel(artery: artery)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        buildArteryViews()
        arteryViews.forEach {
            view in
            view.backgroundColor = .clear
            view.dataSource = self
            self.view.addSubview(view)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        arteryViews.forEach { $0.frame = self.view.bounds }
    }
    
    private func buildArteryViews() {
        if let systemOrigin = model.systemOrigins?.first {
            if let systemTerminus = model.systemTermini?.first {
                let viewModel = ArteryViewModel(borderColor: model.borderColor, fillColor: model.fillColor, originSystem: systemOrigin, terminusSystem: systemTerminus)
                let view = ArteryView(viewModel: viewModel)
                arteryViews.append(view)
            }
        }
    }
}

extension ArteryViewController: ArteryViewDataSource {
    var paddingSize: CGSize { return dataSource?.paddingSize ?? CGSize.zero }
    
    func findRect(system: System) -> CGRect {
        return dataSource?.findRect(system: system) ?? CGRect.zero
    }
}
