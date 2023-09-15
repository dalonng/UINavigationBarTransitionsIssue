//
//  Transition.swift
//  UINavigationBarTransitionsIssue
//
//  Created by 大龙 on 2023/9/5.
//

import UIKit

final class Transition: NSObject, UIViewControllerTransitioningDelegate {
        
    static let shared = Transition()
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        EnterLandscapeTransition()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        ExitLandscapeTransition()
    }
}

final class EnterLandscapeTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to) else {
            return
        }
        guard let to = transitionContext.viewController(forKey: .to) as? LandscapeViewController else {
            return
        }
        
        transitionContext.containerView.backgroundColor = .clear
        
        toView.frame = transitionContext.containerView.bounds
        toView.backgroundColor = .clear
        
        transitionContext.containerView.addSubview(toView)
        transitionContext.containerView.addSubview(to.transitionView)
        to.transitionView.addSubview(to.playerView)
        to.transitionView.backgroundColor = .yellow

        to.transitionView.frame = to.beforeFrame;
        let x = to.beforeFrame.width * 0.5 + to.beforeFrame.minX
        let y = to.beforeFrame.height * 0.5 + to.beforeFrame.minY
        to.transitionView.center = CGPoint(x: y, y: x)
        to.transitionView.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi / 2))

        to.playerView.frame = to.transitionView.bounds;
                
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .layoutSubviews) {
            to.playerView.frame = to.finalFrame
            
            to.transitionView.transform = .identity
            to.transitionView.frame = transitionContext.containerView.bounds
        } completion: { finished in
            to.playerView.frame = to.finalFrame
            to.view.bringSubviewToFront(to.button)
            to.transitionView.removeFromSuperview()
            to.playerView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
}

final class ExitLandscapeTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else {
            return
        }
        guard let toView = transitionContext.view(forKey: .to) else {
            return
        }
        guard let from = transitionContext.viewController(forKey: .from) as? LandscapeViewController else {
            return
        }
        
        transitionContext.containerView.backgroundColor = .clear
        transitionContext.containerView.addSubview(from.transitionView)
        from.transitionView.addSubview(from.playerView)
        
        from.transitionView.frame = from.beforeFrame
        from.playerView.frame = from.transitionView.bounds;
        from.playerView.edgesEqualToSuperview()
        from.playerView.layoutIfNeeded()

        transitionContext.containerView.addSubview(toView)
        transitionContext.containerView.bringSubviewToFront(toView)
        transitionContext.containerView.insertSubview(toView, belowSubview: fromView)
        fromView.removeFromSuperview()
        
        // 转屏结束前 `containerView` 为横屏坐标系，故中心点需要反转
        let x = from.finalFrame.width * 0.5 + from.finalFrame.minX
        let y = from.finalFrame.height * 0.5 + from.finalFrame.minY
        
        var finalCenter = CGPoint.zero
        var finalTransform = CGAffineTransform.identity
        
        finalCenter = CGPoint(x: y, y: x)
        finalTransform = CGAffineTransform(rotationAngle: -(CGFloat.pi / 2))
        
        toView.transform = finalTransform
        from.transitionView.center = finalCenter
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .layoutSubviews) {
            from.transitionView.frame = from.finalFrame
            from.transitionView.transform = finalTransform
            from.transitionView.center = finalCenter            
            from.playerView.frame = from.transitionView.bounds;
        } completion: { finished in
            from.playerView.frame = from.transitionView.bounds;
            toView.transform = .identity
            from.transitionView.removeFromSuperview()
            from.view.addSubview(from.playerView)
            transitionContext.completeTransition(true)
        }
    }
}

extension UIView {
    func edgesEqualToSuperview() {
        guard let superview else {
            return
        }
        superview.translatesAutoresizingMaskIntoConstraints = true
        leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
        topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }
}
