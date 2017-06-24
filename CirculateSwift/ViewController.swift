//
//  ViewController.swift
//  CirculateSwift
//
//  Created by Kaden, Joshua on 6/16/17.
//  Copyright © 2017 Chadford Software. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        showDiagramViewController()
    }
    
    private func showDiagramViewController() {
        let vc = DiagramViewController()
        present(vc, animated: true, completion: nil)
    }
}
