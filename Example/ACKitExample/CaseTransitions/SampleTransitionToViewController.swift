//
//  SampleTransitionToViewController.swift
//  ACKit
//
//  Created by Austin Chen on 2017-08-19.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class SampleTransitionToViewController: UIViewController {
    var transitionManager: ACHorizontalTransitionManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(slide(recognizer:)))
        self.view.addGestureRecognizer(panGesture)
    }
    
    func slide(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            break
        case .changed:
            let t = recognizer.translation(in: self.view)
            if !(transitionManager?.interactiveTransition.hasStarted ?? false) {
                if t.x > 0 {
                    self.dismiss(animated: true, completion: nil)
                }
                transitionManager?.interactiveTransition.hasStarted = true
            }
            
            guard transitionManager?.interactiveTransition.hasStarted ?? false
                else { return }
            
            let percent = fabs(t.x/self.view.frame.width)
            transitionManager?.interactiveTransition.update(percent)
            transitionManager?.interactiveTransition.shouldFinish = percent > 0.5
            break
        case .cancelled:
            transitionManager?.interactiveTransition.completionSpeed = 0.999 // fix apple bug below iOS 11, https://stackoverflow.com/questions/19626374/ios-7-custom-transition-glitch
            transitionManager?.interactiveTransition.cancel()
            transitionManager?.interactiveTransition.hasStarted = false
        case .ended:
            guard transitionManager?.interactiveTransition.hasStarted ?? false
                else { return }
            
            transitionManager?.interactiveTransition.completionSpeed = 0.999 // fix apple bug below iOS 11, https://stackoverflow.com/questions/19626374/ios-7-custom-transition-glitch
            if transitionManager?.interactiveTransition.shouldFinish ?? false {
                transitionManager?.interactiveTransition.finish()
            } else {
                transitionManager?.interactiveTransition.cancel()
            }
            transitionManager?.interactiveTransition.hasStarted = false
            break
        default:
            break
        }
    }
}
