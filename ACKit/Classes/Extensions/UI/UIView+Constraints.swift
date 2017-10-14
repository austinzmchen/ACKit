//
//  UIView+Constraints.swift
//  SnackableTV
//
//  Created by Austin Chen on 2017-09-04.
//  Copyright © 2017 Austin Chen. All rights reserved.
//

import Foundation

extension UIView {
    
    open func snapTopBottom(toView view: UIView) {
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    open func snapLeadTrail(toView view: UIView) {
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    open func snapAll(toView view: UIView) {
        snapTopBottom(toView: view)
        snapLeadTrail(toView: view)
    }
    
    open func snapTopBottomToSuperview() {
        guard let sv = self.superview
            else { return }
        
        snapTopBottom(toView: sv)
    }
    
    open func snapLeadTrailToSuperview() {
        guard let sv = self.superview
            else { return }
        
        snapLeadTrail(toView: sv)
    }
    
    open func snapAllToSuperview() {
        snapTopBottomToSuperview()
        snapLeadTrailToSuperview()
    }
}
