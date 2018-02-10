//
//  CaseAccessibilityView.swift
//  ACKit_Example
//
//  Created by Austin Chen on 2018-01-29.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class CaseAccessibilityView: UIView {
    
    weak var label1: UILabel!
    weak var button3: UIButton!
    weak var label2: UILabel!
    
    lazy var ablyElements: [AnyObject] = {
        return [label1, label2, button3]
    }()
    
//    override func accessibilityElementCount() -> Int {
//        return 3
//    }
//    
//    override open func accessibilityElement(at index: Int) -> Any? {
//        return ablyElements[index]
//    }
//    
//    override func index(ofAccessibilityElement element: Any) -> Int {
//        return ablyElements.index{ $0 === (element as? AnyObject)} ?? Int.max
//    }
}
