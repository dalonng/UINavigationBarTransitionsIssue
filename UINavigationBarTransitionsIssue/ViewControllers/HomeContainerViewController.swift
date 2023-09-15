//
//  HomeContainerViewController.swift
//  UINavigationBarTransitionsIssue
//
//  Created by 大龙 on 2023/9/8.
//

import UIKit

class HomeContainerViewController: BaseViewController {
    
    let currentNavigationController = NavigationController(navigationBarClass: UINavigationBar.self,
                                                                 toolbarClass: UIToolbar.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "HomeContainerViewController"
    
        addChild(currentNavigationController)
        view.addSubview(currentNavigationController.view)
        currentNavigationController.view.frame = view.bounds
        currentNavigationController.didMove(toParent: self)
    }

    override var shouldAutorotate: Bool {
        currentNavigationController.shouldAutorotate
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        currentNavigationController.supportedInterfaceOrientations
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        currentNavigationController.preferredInterfaceOrientationForPresentation
    }
    
}
