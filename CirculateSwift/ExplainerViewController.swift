//
//  ExplainerViewController.swift
//  CirculateSwift
//
//  Created by Joshua Kaden on 7/21/17.
//  Copyright © 2017 Chadford Software. All rights reserved.
//

import UIKit

protocol ExplainerViewControllerDelegate: class {
    func didTouch(explainerViewController: ExplainerViewController)
}

final class ExplainerViewController: UIViewController {
    private let containerView = UIView()
    weak var delegate: ExplainerViewControllerDelegate?
    private let titleLabel = UILabel()
    private let touchPoint: CGPoint
    
    init(title: String, touchPoint: CGPoint) {
        titleLabel.text = title
        self.touchPoint = touchPoint
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let touchscreen = TouchableView()
        touchscreen.delegate = self
        view = touchscreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.backgroundColor = .white
        containerView.cornerRadius = 6
        containerView.clipsToBounds = true
        view.addSubview(containerView)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        containerView.addSubview(titleLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleLabel.sizeToFit()
        
        containerView.size = CGSize(width: titleLabel.width + 16, height: titleLabel.height + 16)
        containerView.origin = touchPoint
        containerView.y -= (containerView.height + 16)
        containerView.centerHorizontallyInSuperview()
        
        titleLabel.centerInSuperview()
    }
}

// MARK: - TouchableViewDelegate

extension ExplainerViewController: TouchableViewDelegate {
    func didTouch(touchableView: TouchableView) {
        delegate?.didTouch(explainerViewController: self)
    }
}
