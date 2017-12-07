//
//  SampleTransition2FromViewController.swift
//  ACKit
//
//  Created by Austin Chen on 2017-08-19.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class SampleTransition2FromViewController: UIViewController {
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var transitionManager = ACHorizontalTransitionManager()
    var p = CGPoint.zero
    var animator: UIViewPropertyAnimator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // use LongPress gesture to sub panGesture because UIPanGesture has initial delay
        let panGesture = UILongPressGestureRecognizer(target: self, action: #selector(slide(recognizer:)))
        panGesture.minimumPressDuration = 0.0
        panGesture.allowableMovement = CGFloat.infinity
        self.view.addGestureRecognizer(panGesture)
    }
    
    @objc func slide(recognizer: UILongPressGestureRecognizer) {
        switch recognizer.state {
        case .began:
            p = recognizer.location(in: self.view)
            break
        case .changed:
            let t = recognizer.location(in: nil)
            if t.x < p.x,
                !transitionManager.interactiveTransition.hasStarted
            {
                self.performSegue(withIdentifier: "gestureTransitionToVC", sender: nil)
                transitionManager.interactiveTransition.hasStarted = true
            }
            
            let d = self.view.frame.width - fabs(t.x)
            
            guard transitionManager.interactiveTransition.hasStarted
                else { return }
            
            let percent = fabs(d/self.view.frame.width)
            transitionManager.interactiveTransition.update(percent)
            transitionManager.interactiveTransition.shouldFinish = percent > 0.3
            break
        case .cancelled:
            transitionManager.interactiveTransition.completionSpeed = 0.999 // fix apple bug below iOS 11, https://stackoverflow.com/questions/19626374/ios-7-custom-transition-glitch
            transitionManager.interactiveTransition.cancel()
            transitionManager.interactiveTransition.hasStarted = false
        case .ended:
            guard transitionManager.interactiveTransition.hasStarted
                else { return }
            
            transitionManager.interactiveTransition.completionSpeed = 0.999 // fix apple bug below iOS 11, https://stackoverflow.com/questions/19626374/ios-7-custom-transition-glitch
            if transitionManager.interactiveTransition.shouldFinish {
                transitionManager.interactiveTransition.finish()
            } else {
                transitionManager.interactiveTransition.cancel()
            }
            transitionManager.interactiveTransition.hasStarted = false
            break
        default:
            break
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gestureTransitionToVC",
            let toVC = segue.destination as? SampleTransitionToViewController {
            toVC.transitionManager = transitionManager
            toVC.transitioningDelegate = transitionManager
        }
    }
}
