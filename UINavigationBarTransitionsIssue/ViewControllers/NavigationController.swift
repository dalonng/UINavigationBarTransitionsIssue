//
//  NavigationController.swift
//  UINavigationBarTransitionsIssue
//
//  Created by 大龙 on 2023/9/5.
//

import UIKit
import Foundation

class NavigationController: UINavigationController {
        
    override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
        addChild(ViewController())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var shouldAutorotate: Bool {
        viewControllers.last?.shouldAutorotate ?? false
    }
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        viewControllers.last?.supportedInterfaceOrientations ?? Coordinator.shared.supportedInterfaceOrientations
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        viewControllers.last?.preferredInterfaceOrientationForPresentation ?? .portrait
    }
}
