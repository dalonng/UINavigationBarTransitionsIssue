//
//  HomeViewController.swift
//  UINavigationBarTransitionsIssue
//
//  Created by 大龙 on 2023/9/8.
//

import UIKit

class HomeViewController: BaseViewController {
        
    let contentViewController = HomeContainerViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        
        contentViewController.willMove(toParent: self)
        contentViewController.view.frame = view.bounds
        contentViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addChild(contentViewController)
        view.addSubview(contentViewController.view)
        contentViewController.didMove(toParent: self)
    }
        
    override var shouldAutorotate: Bool {
        false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        contentViewController.supportedInterfaceOrientations
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        contentViewController.preferredInterfaceOrientationForPresentation
    }
}
