//
//  LandscapeViewController.swift
//  UINavigationBarTransitionsIssue
//
//  Created by 大龙 on 2023/9/5.
//

import UIKit

class LandscapeViewController: BaseViewController {
    
    var playerView: UIView
    
    var beforeFrame: CGRect
    
    var finalFrame: CGRect
    
    let transitionView = UIView()
    
    var button: UIButton!
        
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        playerView = UIView()
        beforeFrame = .zero
        finalFrame = .zero
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalPresentationStyle = .fullScreen
        transitioningDelegate = Transition.shared
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemPurple
        addButton()
    }
    
    override var shouldAutorotate: Bool {
        true
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        .landscapeRight
    }
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .landscapeRight
    }

    func addButton() {
        var configuraton = UIButton.Configuration.filled()
        configuraton.baseBackgroundColor = .systemPink
        configuraton.title = "dismiss"
        button = UIButton(configuration: configuraton, primaryAction: UIAction() { _ in
            self.dismiss(animated: true) {
                NavigationController.shared?.navigationSupportedInterfaceOrientations = .portrait
                
                
                Coordinator.shared.supportedInterfaceOrientations = .portrait
                if #available(iOS 16.0, *) {
                    self.navigationController?.setNeedsUpdateOfSupportedInterfaceOrientations()
                } else {
                    // Fallback on earlier versions
                }
            }
        })
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }    
}
