//
//  ACTargetActionable.swift
//  ACKit
//
//  Created by Austin Chen on 2018-01-22.
//

import UIKit

internal struct TargetActionDictValue {
    var target: Any?
    var sender: Any
    var action: (_ sender: Any)->()
}

typealias TargetActionDict = [UInt: TargetActionDictValue]

public protocol ACTargetActionable {
    func addAction(_ target: Any?, for controlEvents: UIControlEvents, action: @escaping (_ sender: Any)->() )
    func removeAction(_ target: Any?, for controlEvents: UIControlEvents, action: @escaping (_ sender: Any)->() )
}

extension ACTargetActionable where Self: UIControl {
    public func addAction(_ target: Any? = nil, for controlEvents: UIControlEvents, action: @escaping (_ sender: Any)->() ) {
        // add actionable callbacks
        var targetActionDict: TargetActionDict = [:]
        if associatedObject != nil {
            targetActionDict = associatedObject as! TargetActionDict
        }
        targetActionDict[controlEvents.rawValue] = TargetActionDictValue(target: target, sender: self, action: action)
        associatedObject = targetActionDict
        
        // add context
        secondaryAssociatedObject = [kACControlEvents: controlEvents.rawValue]
        
        // add action to proxy selector
        addTarget(self, action: #selector(proxySelector(_:)), for: controlEvents)
    }
    
    public func removeAction(_ target: Any?, for controlEvents: UIControlEvents, action: @escaping (_ sender: Any)->() ) {
        var dict = associatedObject as? TargetActionDict
        dict?.removeValue(forKey: controlEvents.rawValue)
            
        removeTarget(self, action: #selector(proxySelector(_:)), for: controlEvents)
    }
}

extension UIControl: ACTargetActionable {
    
    @objc func proxySelector(_ sender: Any) {
        guard let dict = secondaryAssociatedObject as? [String: UInt],
            let ce = dict[kACControlEvents]
            else {return}
        
        if let targetActionDict = associatedObject as? TargetActionDict,
            let taValue = targetActionDict[ce]
        {
            taValue.action(taValue.sender)
        }
    }
}

private let kACControlEvents = "kACTargetActionableControlEvents"

