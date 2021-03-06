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

protocol ArteryViewControllerDelegate: class {
    func didTouch(point: CGPoint, arteryViewController: ArteryViewController)
}

final class ArteryViewController: UIViewController {
    private(set) var arteryViews: [ArteryView] = []
    weak var dataSource: ArteryViewControllerDataSource?
    weak var delegate: ArteryViewControllerDelegate?
    let model: ArteryModel
    
    init(model: ArteryModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(artery: Artery) {
        self.init(model: ArteryModel(artery: artery))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func loadView() {
        view = SubviewHitTestView()
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: view) else { return }
        delegate?.didTouch(point: point, arteryViewController: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        arteryViews.forEach { $0.frame = self.view.bounds }
    }
    
    private func buildArteryViews() {
        let systemOrigin = model.systemOrigins?.first
        if let systemTerminus = model.systemTermini?.first {
            let viewModel = ArteryViewModel(artery: model.artery, borderColor: model.borderColor, borderColorLight: model.borderColorLight, borderWidth: model.borderWidth, fillColor: model.fillColor, originSystem: systemOrigin, terminusSystem: systemTerminus)
            let view = ArteryView(viewModel: viewModel)
            arteryViews.append(view)
        }
        if let systemTermini = model.systemTermini, systemTermini.count == 2 {
            let systemTerminus = systemTermini[1]
            let viewModel = ArteryViewModel(artery: model.artery, borderColor: model.borderColor, borderColorLight: model.borderColorLight, borderWidth: model.borderWidth, fillColor: model.fillColor, originSystem: systemOrigin, terminusSystem: systemTerminus)
            let view = ArteryView(viewModel: viewModel)
            arteryViews.append(view)
        }
    }
}

extension ArteryViewController: ArteryViewDataSource {
    var aortaX: CGFloat {
        let heartFrame = findRect(system: .heart)
        return heartFrame.maxX + paddingSize.width
    }
    
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
