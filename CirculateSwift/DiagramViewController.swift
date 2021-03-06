//
//  DiagramViewController.swift
//  CirculateSwift
//
//  Created by Joshua Kaden on 6/24/17.
//  Copyright © 2017 Chadford Software. All rights reserved.
//

import UIKit

final class DiagramViewController: UIViewController {
    
    private lazy var arteryAnimators: [ArteryAnimator] = {
        let views = self.arterialViewControllers.flatMap { $0.arteryViews }
        return (1...views.count).map { _ in return ArteryAnimator() }
    }()
    
    private let arterialViewControllers: [ArteryViewController] = [
        ArteryViewController(artery: .aorta),
        ArteryViewController(artery: .carotid),
        ArteryViewController(artery: .celiac),
        ArteryViewController(artery: .gonadal),
        ArteryViewController(artery: .hepatic),
        ArteryViewController(artery: .iliac),
        ArteryViewController(artery: .pulmonary),
        ArteryViewController(artery: .renal),
        ArteryViewController(artery: .subclavian)
    ]
    
    fileprivate let containerView = UIView()
    private let heartAnimator = HeartAnimator()
    private var heartViewController: SystemViewController { return systemViewControllers[2] }
    fileprivate var highlightedViewController: UIViewController?
    fileprivate var isAnimating = false
    internal var paddingSize: CGSize { return CGSize(width: rowSize.width / 5, height: rowSize.height / 1.7) }
    private var rowSize: CGSize { return CGSize(width: view.width / 2, height: view.height / 15) }
    private let rowViews = [UIView(), UIView(), UIView(), UIView(), UIView(), UIView(), UIView(), UIView()]
    
    private let systemViewControllers: [SystemViewController] = [
        SystemViewController(system: .gut),
        SystemViewController(system: .head),
        SystemViewController(system: .heart),
        SystemViewController(system: .leftArm),
        SystemViewController(system: .leftKidney),
        SystemViewController(system: .leftLeg),
        SystemViewController(system: .leftLung),
        SystemViewController(system: .liver),
        SystemViewController(system: .lowerBody),
        SystemViewController(system: .rightArm),
        SystemViewController(system: .rightKidney),
        SystemViewController(system: .rightLeg),
        SystemViewController(system: .rightLung)
    ]
    
    private let touchscreen = TouchableView()
    private var twinWidth: CGFloat { return (rowSize.width / 2) - (rowSize.width / 16) }
    
    private lazy var veinAnimators: [VeinAnimator] = {
        let views = self.veinViewControllers.flatMap { $0.veinViews }
        return (1...views.count).map { _ in return VeinAnimator() }
    }()
    
    private let veinViewControllers: [VeinViewController] = [
        VeinViewController(vein: .gonadal),
        VeinViewController(vein: .hepatic),
        VeinViewController(vein: .hepaticPortal),
        VeinViewController(vein: .iliac),
        VeinViewController(vein: .inferiorVenaCava),
        VeinViewController(vein: .jugular),
        VeinViewController(vein: .pulmonary),
        VeinViewController(vein: .renal),
        VeinViewController(vein: .subclavian),
        VeinViewController(vein: .superiorVenaCava)
    ]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.gray
        
        rowViews.forEach {
            view in
            self.containerView.addSubview(view)
        }
        
        containerView.isUserInteractionEnabled = false
        view.addSubview(containerView)
        
        systemViewControllers.forEach {
            vc in
            let targetView = self.rowViews[vc.viewModel.system.systemRow.rawValue]
            self.adoptChildViewController(vc, targetView: targetView)
        }
        
        arterialViewControllers.forEach {
            vc in
            vc.dataSource = self
            vc.delegate = self
            self.adoptChildViewController(vc)
        }
        
        veinViewControllers.forEach {
            vc in
            vc.dataSource = self
            vc.delegate = self
            self.adoptChildViewController(vc)
        }
        
        touchscreen.delegate = self
        view.addSubview(touchscreen)
        
    }
    
    deinit {
        systemViewControllers.forEach { $0.leaveParentViewController() }
        arterialViewControllers.forEach { $0.leaveParentViewController() }
        veinViewControllers.forEach { $0.leaveParentViewController() }
        highlightedViewController?.leaveParentViewController()
        NotificationCenter.default.removeObserver(self)
    }

    func didChangeOrientation(_ sender: Notification) {
        let shouldStartAnimating = isAnimating
        stopAnimation()
        
        systemViewControllers.forEach {
            $0.view.setNeedsDisplay()
        }
        
        arterialViewControllers.forEach {
            $0.view.setNeedsDisplay()
        }
        
        veinViewControllers.forEach {
            $0.view.setNeedsDisplay()
        }
        
        if shouldStartAnimating {
            startAnimation()
        }
    }
    
    // MARK: - Layout
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        touchscreen.frame = view.bounds
        view.sendSubviewToBack(touchscreen)
        
        layoutRowViews()
        
        systemViewControllers.forEach {
            vc in
            let rowView = self.findRowView(systemVC: vc)
            let system = vc.viewModel.system
            let systemRow = vc.viewModel.system.systemRow
            if systemRow.isTwin {
                vc.view.size = CGSize(width: twinWidth, height: rowView.height)
                switch system {
                case .gut, .rightArm, .rightKidney, .rightLeg, .rightLung:
                    vc.view.x = rowView.width - twinWidth
                default:
                    // no op
                    break
                }
            } else {
                vc.view.size = rowView.size
            }
        }
        
        arterialViewControllers.forEach { $0.view.frame = self.view.bounds }
        veinViewControllers.forEach { $0.view.frame = self.view.bounds }
    }
    
    private func layoutRowViews() {
        var lastMaxY = CGFloat(0)
        for index in 0...7 {
            let systemRow = SystemRow(rawValue: index)!
            let view = rowViews[index]
            view.size = rowSize
            
            view.y = lastMaxY
            switch systemRow {
            case .lungs, .kidneys:
                // room for top and bottom connections
                view.y += paddingSize.height / 1.5
            default:
                // no op
                break
            }
            
            lastMaxY = view.maxY + paddingSize.height
        }
        
        guard let lastRowView = rowViews.last else { return }
        containerView.size = CGSize(width: rowSize.width, height: lastRowView.maxY)
        
        containerView.centerInSuperview()
        view.bringSubviewToFront(containerView)
        
        if let highlightedView = highlightedViewController?.view {
            view.bringSubviewToFront(highlightedView)
        }
    }
    
    // MARK: - Private
    
    fileprivate func findRowView(system: System) -> UIView {
        let systemRow = system.systemRow
        return rowViews[systemRow.rawValue]
    }
    
    private func findRowView(systemVC: SystemViewController) -> UIView {
        return findRowView(system: systemVC.viewModel.system)
    }
    
    fileprivate func findSystemVC(system: System) -> SystemViewController {
        return systemViewControllers
            .filter { $0.viewModel.system == system }
            .first!
    }
    
    fileprivate func handleTouch(point: CGPoint, viewController: UIViewController) {
        if let _ = self.highlightedViewController { return }
        
        var title: String = ""
        
        if let arteryViewController = viewController as? ArteryViewController {
            let model = ArteryModel(artery: arteryViewController.model.artery, borderWidth: 6, isHighlighted: true)
            let vc = ArteryViewController(model: model)
            vc.dataSource = self
            self.highlightedViewController = vc
            title = model.artery.title
        }
        
        if let veinViewController = viewController as? VeinViewController {
            let model = VeinModel(vein: veinViewController.model.vein, borderWidth: 6, isHighlighted: true)
            let vc = VeinViewController(model: model)
            vc.dataSource = self
            self.highlightedViewController = vc
            title = model.vein.title
        }
        
        guard let highlightedViewController = highlightedViewController else { return }
        highlightedViewController.view.backgroundColor = UIColor.black.withAlphaComponent(0.65)
        highlightedViewController.view.frame = view.bounds
        adoptChildViewController(highlightedViewController)
        
        let origin: CGPoint = point

        let vc = ExplainerViewController(title: title, touchPoint: origin)
        vc.delegate = self
        vc.view.frame = highlightedViewController.view.bounds
        highlightedViewController.adoptChildViewController(vc)
    }
    
    fileprivate func startAnimation() {
        startHeartAnimation()
        startArterialAnimation()
        startVeinAnimation()
        isAnimating = true
    }
    
    private func startArterialAnimation() {
        let views = arterialViewControllers.flatMap { $0.arteryViews }
        let viewsAndAnimators = zip(views, arteryAnimators)
        viewsAndAnimators.forEach { $0.1.start(view: $0.0) }
    }
    
    private func startHeartAnimation() {
        let heartView = heartViewController.view as! SystemView
        heartAnimator.start(view: heartView)
    }
    
    private func startVeinAnimation() {
        let views = veinViewControllers.flatMap { $0.veinViews }
        let viewsAndAnimators = zip(views, veinAnimators)
        viewsAndAnimators.forEach { $0.1.start(view: $0.0) }
    }
    
    fileprivate func stopAnimation() {
        stopHeartAnimation()
        stopArterialAnimation()
        stopVeinAnimation()
        isAnimating = false
    }
    
    private func stopArterialAnimation() {
        arteryAnimators.forEach { $0.stop() }
    }
    
    private func stopHeartAnimation() {
        heartAnimator.stop()
    }
    
    private func stopVeinAnimation() {
        veinAnimators.forEach { $0.stop() }
    }
}

// MARK: - ArteryViewControllerDataSource

extension DiagramViewController: ArteryViewControllerDataSource {
    func findRect(system: System) -> CGRect {
        let systemVC = findSystemVC(system: system)
        return view.convert(systemVC.view.bounds, from: systemVC.view)
    }
}

// MARK: - ArteryViewControllerDelegate

extension DiagramViewController: ArteryViewControllerDelegate {
    func didTouch(point: CGPoint, arteryViewController: ArteryViewController) {
        handleTouch(point: point, viewController: arteryViewController)
    }
}

// MARK: - ExplainerViewControllerDelegate

extension DiagramViewController: ExplainerViewControllerDelegate {
    func didTouch(explainerViewController: ExplainerViewController) {
        explainerViewController.leaveParentViewController()
        highlightedViewController?.leaveParentViewController()
        highlightedViewController = nil
    }
}

// MARK: - TouchableViewDelegate

extension DiagramViewController: TouchableViewDelegate {
    func didTouch(touchableView: TouchableView) {
        if isAnimating {
            stopAnimation()
        } else {
            startAnimation()
        }
    }
}

// MARK: - VeinViewControllerDataSource

extension DiagramViewController: VeinViewControllerDataSource {
    // no op
}

// MARK: - VeinViewControllerDelegate

extension DiagramViewController: VeinViewControllerDelegate {
    func didTouch(point: CGPoint, veinViewController: VeinViewController) {
        handleTouch(point: point, viewController: veinViewController)
    }
}
