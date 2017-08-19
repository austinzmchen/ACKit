//
//  ACHorizontalSlideInAnimator.swift
//  SnackableTV
//
//  Created by Austin Chen on 2017-08-15.
//  Copyright © 2017 Austin Chen. All rights reserved.
//

import UIKit

class ACHorizontalSlideInAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else { return }
        
        transitionContext.containerView.addSubview(toVC.view)
        transitionContext.containerView.sendSubview(toBack: toVC.view)
        
        toVC.view.frame.origin.x = toVC.view.frame.size.width
        
        UIView.animate(
            withDuration: self.transitionDuration(using: transitionContext),
            animations: {
                fromVC.view.frame.origin.x = fromVC.view.frame.width * -1
                toVC.view.frame.origin.x = fromVC.view.frame.maxX
            },
            completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
    }
}
