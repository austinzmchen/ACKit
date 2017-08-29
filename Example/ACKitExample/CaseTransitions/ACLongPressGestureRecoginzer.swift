//
//  ACLongPressGestureRecoginzer.swift
//  ACKit
//
//  Created by Austin Chen on 2017-08-29.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class ACLongPressGestureRecoginzer: UILongPressGestureRecognizer {
    /*
    typealias _Record = (target: AnyObject, action: Selector)
    var _records = [Int: _Record]()
    
    override init(target: Any?, action: Selector?) {
        super.init(target: nil, action: nil) // can't use 'self' here
        
        guard let t = target, let a = action
            else { return }
        self.addTarget(t, action: a)
    }
    
    func acSelector(recognizer: UILongPressGestureRecognizer) {
        
    }
    
    override func addTarget(_ target: Any, action: Selector) {
        guard let t = target as? AnyObject
            else { return }
        
        let key = t.hashValue ^ action.hashValue
        let value = _Record(target: t, action: action)
        _records[key] = value
        
        super.addTarget(t, action: action)
    }
    */
}
