//
//  PortraitViewController.swift
//  UINavigationBarTransitionsIssue
//
//  Created by 大龙 on 2023/9/5.
//

import UIKit

class PortraitViewController: BaseViewController {
    
    let playerView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        title = "PortraitViewController"
        setup()
        addBackButton()
        addButton()
    }
    
    override var shouldAutorotate: Bool {
        false
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        .portrait
    }
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: true)
        print("viewWillAppear center: \(String(describing: navigationController?.navigationBar.center))")
//        navigationController?.setNavigationBarHidden(true, animated: false)
        print("viewWillAppear2 center: \(String(describing: navigationController?.navigationBar.center))")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        printNavigationInfo()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        printNavigationInfo()
    }
    
    func setup() {
        view.addSubview(playerView)
        playerView.backgroundColor = .red
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        playerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        playerView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func addBackButton() {
        var configuraton = UIButton.Configuration.filled()
        configuraton.baseBackgroundColor = .systemMint
        configuraton.title = "Back to ViewController"
        let button = UIButton(configuration: configuraton, primaryAction: UIAction() { _ in
            self.navigationController?.popViewController(animated: true)
        })
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        button.widthAnchor.constraint(equalToConstant: 400).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func addButton() {
        var configuraton = UIButton.Configuration.filled()
        configuraton.baseBackgroundColor = .systemPink
        configuraton.title = "Transition to LandscapeViewController"
        let button = UIButton(configuration: configuraton, primaryAction: UIAction() { _ in
            self.present()
        })
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100).isActive = true
        button.widthAnchor.constraint(equalToConstant: 400).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func present() {
        let landscapeViewController = LandscapeViewController()
        landscapeViewController.playerView = playerView
        landscapeViewController.beforeFrame = playerView.frame
        landscapeViewController.finalFrame = view.bounds
        
        NavigationController.shared?.navigationSupportedInterfaceOrientations = .all
        
        Coordinator.shared.supportedInterfaceOrientations = .landscape
        
        navigationController?.parent?.parent?.present(landscapeViewController, animated: true)
//        present(landscapeViewController, animated: true)
    }
}
