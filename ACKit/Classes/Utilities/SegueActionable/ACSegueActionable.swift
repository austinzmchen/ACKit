
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
            
            if !SwizzledSet.shared.isSwizzled(type(of: self)) {
                // swizzle performSegue
                ACSwizzle.swizzleSelector(#selector(prepare(for:sender:)),
                                          withNewSelector: #selector(swizzledPrepare(for:sender:)), on: self)
                SwizzledSet.shared.setSwizzled(type(of: self))
            }
        } else {
            var segueActionDict: SegueActionDict = associatedObject as! SegueActionDict
            segueActionDict.removeValue(forKey: identifier)
            segueActionDict[identifier] = action
            associatedObject = segueActionDict // needed otherwise action being performed uses old parameters
        }
        
        // proceed
        performSegue(withIdentifier: identifier, sender: nil)
    }
}

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

private class SwizzledSet {
    static let shared = SwizzledSet()
    var swizzledTypes = Set<String>()
    
    func isSwizzled(type: String) -> Bool {
        return swizzledTypes.contains(type)
    }
    
    func setSwizzled(type: String) {
        swizzledTypes.insert(type)
    }
}

extension SwizzledSet {
    func isSwizzled(_ a: Any) -> Bool {
        let type = String(describing: a)
        return swizzledTypes.contains(type)
    }
    
    func setSwizzled(_ a: Any) {
        let type = String(describing: a)
        swizzledTypes.insert(type)
    }
}
