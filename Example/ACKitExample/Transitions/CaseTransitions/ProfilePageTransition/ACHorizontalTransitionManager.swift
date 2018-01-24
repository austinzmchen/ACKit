//
//  ACHorizontalTransitionManager.swift
//  SnackableTV
//
//  Created by Austin Chen on 2017-08-15.
//  Copyright © 2017 Austin Chen. All rights reserved.
//

import UIKit

class ACHorizontalTransitionManager: NSObject {
    var transitionContext: UIViewControllerContextTransitioning?
    var interactiveTransition = ACHorizontalInteractiveTransition()
}

extension ACHorizontalTransitionManager: UIViewControllerTransitioningDelegate {
    // delegate methods
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ACHorizontalSlideInAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ACHorizontalSlideOutAnimator()
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition
    }
}
