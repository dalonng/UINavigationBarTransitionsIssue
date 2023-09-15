//
//  NavigationController.swift
//  UINavigationBarTransitionsIssue
//
//  Created by 大龙 on 2023/9/5.
//

import UIKit
import Foundation

class NavigationController: UINavigationController {
    
    static var shared: NavigationController?
    
    var navigationSupportedInterfaceOrientations: UIInterfaceOrientationMask = .portrait
    
    var observation: NSKeyValueObservation?
    
    override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
        addChild(ViewController())
    }
    
    
    override class func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "_contentOverlayInsets", let change {
            print("_contentOverlayInsets changed from: \(change[NSKeyValueChangeKey.oldKey]!), updated to: \(change[NSKeyValueChangeKey.newKey]!)")
        }
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

class NavigationBar: UINavigationBar {
    
    var isChanged: Bool = false
    
    override var center: CGPoint {
        didSet {
            if abs(center.y) > 200 {
                isChanged = true
                print("center changed: \(center)")
            }
            if isChanged, abs(center.y) < 200 {
                print("center cr: \(center)")
                isChanged = false
            }
        }
    }
    
    override var frame: CGRect {
        didSet {
            if abs(frame.origin.y) > 290 {
                print("frame: \(frame)")
            }
        }
    }
    
    override var transform: CGAffineTransform {
        didSet {
            print("transform: \(transform)")
        }
    }
    
}
