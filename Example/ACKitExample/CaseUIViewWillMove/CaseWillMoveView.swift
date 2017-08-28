//
//  CaseWillMoveView.swift
//  ACKit
//
//  Created by Austin Chen on 2017-08-27.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class CaseWillMoveView: UIView {
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        print("willMove")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        print("didMove")
    }
}
