//
//  SampleTransitionFromViewController.swift
//  ACKit
//
//  Created by Austin Chen on 2017-08-19.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class SampleTransitionFromViewController: UIViewController {
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var transitionManager = ACHorizontalTransitionManager()
    
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
            if !transitionManager.interactiveTransition.hasStarted {
                if t.x < 0 {
                    self.performSegue(withIdentifier: "gestureTransitionToVC", sender: nil)
                }
                transitionManager.interactiveTransition.hasStarted = true
            }
            
            guard transitionManager.interactiveTransition.hasStarted
                else { return }
            
            let percent = fabs(t.x/self.view.frame.width)
            transitionManager.interactiveTransition.update(percent)
            transitionManager.interactiveTransition.shouldFinish = percent > 0.5
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

extension SampleTransitionFromViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("viewDidDisappear")
    }
}
