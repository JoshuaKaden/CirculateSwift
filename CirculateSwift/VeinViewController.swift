//
//  VeinViewController.swift
//  CirculateSwift
//
//  Created by Joshua Kaden on 7/9/17.
//  Copyright © 2017 Chadford Software. All rights reserved.
//

import UIKit

protocol VeinViewControllerDataSource: class {
    var paddingSize: CGSize { get }
    func findRect(system: System) -> CGRect
}

protocol VeinViewControllerDelegate: class {
    func didTouch(point: CGPoint, veinViewController: VeinViewController)
}

final class VeinViewController: UIViewController {
    private(set) var veinViews: [VeinView] = []
    weak var dataSource: VeinViewControllerDataSource?
    weak var delegate: VeinViewControllerDelegate?
    let model: VeinModel
    
    init(model: VeinModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(vein: Vein) {
        self.init(model: VeinModel(vein: vein))
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
        
        buildVeinViews()
        veinViews.forEach {
            view in
            view.backgroundColor = .clear
            view.dataSource = self
            self.view.addSubview(view)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: view) else { return }
        delegate?.didTouch(point: point, veinViewController: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        veinViews.forEach { $0.frame = self.view.bounds }
    }
    
    private func buildVeinViews() {
        let systemTerminus = model.systemTermini?.first
        if let systemOrigin = model.systemOrigins?.first {
            let viewModel = VeinViewModel(vein: model.vein, borderColor: model.borderColor, borderWidth: model.borderWidth, fillColor: model.fillColor, originSystem: systemOrigin, terminusSystem: systemTerminus)
            let view = VeinView(viewModel: viewModel)
            veinViews.append(view)
        }
        if let systemOrigins = model.systemOrigins, systemOrigins.count == 2 {
            let systemOrigin = systemOrigins[1]
            let viewModel = VeinViewModel(vein: model.vein, borderColor: model.borderColor, borderWidth: model.borderWidth, fillColor: model.fillColor, originSystem: systemOrigin, terminusSystem: systemTerminus)
            let view = VeinView(viewModel: viewModel)
            veinViews.append(view)
        }
    }
}

extension VeinViewController: VeinViewDataSource {
    var aortaX: CGFloat {
        let heartFrame = findRect(system: .heart)
        return heartFrame.maxX + (dataSource?.paddingSize.width ?? 0)
    }

    var venaCavaX: CGFloat {
        let heartFrame = findRect(system: .heart)
        return heartFrame.origin.x - paddingSize.width
    }
    
    var paddingSize: CGSize {
        guard let paddingSize = dataSource?.paddingSize else { return CGSize.zero }
        if model.vein == .pulmonary {
            return CGSize(width: paddingSize.width / 2, height: paddingSize.height)
        }
        return paddingSize
    }
    
    func findRect(system: System) -> CGRect {
        return dataSource?.findRect(system: system) ?? CGRect.zero
    }
}
