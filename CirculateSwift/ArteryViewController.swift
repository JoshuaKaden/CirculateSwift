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
        let systemOrigin = model.systemOrigins?.first
        if let systemTerminus = model.systemTermini?.first {
            let viewModel = ArteryViewModel(artery: model.artery, borderColor: model.borderColor, fillColor: model.fillColor, originSystem: systemOrigin, terminusSystem: systemTerminus)
            let view = ArteryView(viewModel: viewModel)
            arteryViews.append(view)
        }
        if let systemTermini = model.systemTermini, systemTermini.count == 2 {
            let systemTerminus = systemTermini[1]
            let viewModel = ArteryViewModel(artery: model.artery, borderColor: model.borderColor, fillColor: model.fillColor, originSystem: systemOrigin, terminusSystem: systemTerminus)
            let view = ArteryView(viewModel: viewModel)
            arteryViews.append(view)
        }
    }
}

extension ArteryViewController: ArteryViewDataSource {
    var paddingSize: CGSize {
        guard let paddingSize = dataSource?.paddingSize else { return CGSize.zero }
        if model.artery == .pulmonary {
            return CGSize(width: paddingSize.width / 2, height: paddingSize.height)
        }
        return paddingSize
    }
    
    func findRect(system: System) -> CGRect {
        return dataSource?.findRect(system: system) ?? CGRect.zero
    }
}
