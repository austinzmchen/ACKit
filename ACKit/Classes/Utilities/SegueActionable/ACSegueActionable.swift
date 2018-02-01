//
//  ACSegueActionable.swift
//  ACKit
//
//  Created by Austin Chen on 2018-01-22.
//

import UIKit

public protocol ACSegueActionable {
    typealias SegueActionDict = [String: (_ segue: UIStoryboardSegue)->()]
    
    func performSegue(withIdentifier identifier: String, action: @escaping (_ segue: UIStoryboardSegue)->() )
}

extension ACSegueActionable where Self: UIViewController {
    public func performSegue(withIdentifier identifier: String, action: @escaping (_ segue: UIStoryboardSegue)->() ) {
        // add actionable callbacks
        if associatedObject == nil {
            var segueActionDict: SegueActionDict = [:]
            segueActionDict[identifier] = action
            associatedObject = segueActionDict
            
            // swizzle performSegue
            ACSwizzle.swizzleSelector(#selector(prepare(for:sender:)), withNewSelector: #selector(swizzledPrepare(for:sender:)), on: self)
        } else {
            var segueActionDict: SegueActionDict = associatedObject as! SegueActionDict
            segueActionDict[identifier] = action
        }
        
        // proceed
        performSegue(withIdentifier: identifier, sender: nil)
    }
}

