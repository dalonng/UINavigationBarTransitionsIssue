//
//  ViewController.swift
//  UINavigationBarTransitionsIssue
//
//  Created by 大龙 on 2023/9/5.
//

import UIKit

class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        title = "Main"
        navigationController?.navigationBar.backgroundColor = .systemBlue
        addButton()
    }
    
    override var shouldAutorotate: Bool {
        true
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        .portrait
    }
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }    
    
    func addButton() {
        var configuraton = UIButton.Configuration.filled()
        configuraton.title = "push"
        let button = UIButton(configuration: configuraton, primaryAction: UIAction() { _ in
            self.navigationController?.pushViewController(PortraitViewController(), animated: true)
        })
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}

