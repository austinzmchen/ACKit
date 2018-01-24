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
    var p = CGPoint.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // use LongPress gesture to sub panGesture because UIPanGesture has initial delay
        let panGesture = UILongPressGestureRecognizer(target: self, action: #selector(slide(recognizer:)))
        panGesture.minimumPressDuration = 0.5 // 0.0 prevent dismiss button to work; fine tune this value
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
                performSegue(withSegueIdentifier: .gestureTransitionToVC, sender: nil)
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
        guard let i = segue.identifier,
            let segueId = SegueIdentifier(rawValue: i)
            else {return}
        
        switch segueId {
        case .gestureTransitionToVC:
            if let toVC = segue.destination as? SampleTransitionToViewController {
                toVC.transitionManager = transitionManager
                toVC.transitioningDelegate = transitionManager
            }
        default:
            break
        }
    }
}


enum SegueIdentifier: String {
    case gestureTransitionToVC
}

// option 1
/* regular extenion methods
 pro: easy, methods added to all UIViewController instance
 con:
 */
extension UIViewController {
    func performSegue(withSegueIdentifier id: SegueIdentifier, sender: Any?) {
        performSegue(withIdentifier: id.rawValue, sender: sender)
    }
    
    func segueIdentifierFor(segue: UIStoryboardSegue) -> SegueIdentifier? {
        guard let i = segue.identifier,
            let segueId = SegueIdentifier(rawValue: i)
            else { return nil }
        return segueId
    }
}

// option 2
/* protocol extenion methods
 pro: finer control, UIViewController/subclasses can subscribe to the methods by extending the protocol
 con: methods added to all UIViewController instance, whether UIViewController/subclasses likes or not
 */
protocol SegueHandleType {
}

extension SegueHandleType where Self: UIViewController {
    func performSegue(withSegueIdentifier id: SegueIdentifier, sender: Any?) {
        performSegue(withIdentifier: id.rawValue, sender: sender)
    }
    
    func segueIdentifierFor(segue: UIStoryboardSegue) -> SegueIdentifier? {
        guard let i = segue.identifier,
            let segueId = SegueIdentifier(rawValue: i)
            else { return nil }
        return segueId
    }
}

extension UIViewController: SegueHandleType {}

