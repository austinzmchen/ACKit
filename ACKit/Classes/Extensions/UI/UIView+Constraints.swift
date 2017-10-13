//
//  UIView+Constraints.swift
//  SnackableTV
//
//  Created by Austin Chen on 2017-09-04.
//  Copyright © 2017 Austin Chen. All rights reserved.
//

import Foundation

extension UIView {
    
    func snapTopBottom(toView view: UIView) {
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func snapLeadTrail(toView view: UIView) {
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func snapAll(toView view: UIView) {
        snapTopBottom(toView: view)
        snapLeadTrail(toView: view)
    }
    
    func snapTopBottomToSuperview() {
        guard let sv = self.superview
            else { return }
        
        snapTopBottom(toView: sv)
    }
    
    func snapLeadTrailToSuperview() {
        guard let sv = self.superview
            else { return }
        
        snapLeadTrail(toView: sv)
    }
    
    func snapAllToSuperview() {
        snapTopBottomToSuperview()
        snapLeadTrailToSuperview()
    }
}
