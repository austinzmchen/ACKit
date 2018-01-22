//
//  UIViewController+SegueActionable.swift
//  ACKit
//
//  Created by Austin Chen on 2018-01-22.
//

import UIKit

extension UIViewController: ACSegueActionable {
    @objc func swizzledPrepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueId = segue.identifier,
            let segueActionDict = associatedObject as? SegueActionDict,
            let segueAction = segueActionDict[segueId]
        {
            segueAction(segue)
        }
        
        // call old method
        swizzledPrepare(for: segue, sender: nil) // this method signature actually points to the old one, prepare(for: sender)
    }
}
