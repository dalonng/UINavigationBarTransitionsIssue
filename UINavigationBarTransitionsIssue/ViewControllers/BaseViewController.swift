//
//  BaseViewController.swift
//  UINavigationBarTransitionsIssue
//
//  Created by 大龙 on 2023/9/8.
//

import UIKit

class BaseViewController: UIViewController {
    
    let titleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .random
        titleLabel.font = .systemFont(ofSize: 20)
        titleLabel.textColor = .random
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        titleLabel.text = typeString
    }

}

extension UIViewController {
    
    var typeString: String {
        if let type = NSStringFromClass(type(of: self)).split(separator: ".").last {
            return String(type)
        }
        return ""
    }
}

extension UIColor {
    public static var random: UIColor {
        UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
    }
}
