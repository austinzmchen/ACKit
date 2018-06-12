//
//  UIView+Constraints.swift
//  SnackableTV
//
//  Created by Austin Chen on 2017-09-04.
//  Copyright © 2017 Austin Chen. All rights reserved.
//

import UIKit

/*
 subview.snp.makeConstraints { (make) in
    make.top.bottom.left.right.equalTo(view)
 }
 
 subview.snp.makeConstraints { (make) in
    make.width.height.equalTo(200)
    make.centerX.centerY.equalTo(view)
 }
 */

protocol SnappableLayoutGuideType {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
}

class SnappableLayoutGuide: SnappableLayoutGuideType {
    var leadingAnchor: NSLayoutXAxisAnchor
    var trailingAnchor: NSLayoutXAxisAnchor
    var topAnchor: NSLayoutYAxisAnchor
    var bottomAnchor: NSLayoutYAxisAnchor
    
    init(leadingAnchor: NSLayoutXAxisAnchor,
         trailingAnchor: NSLayoutXAxisAnchor,
         topAnchor: NSLayoutYAxisAnchor,
         bottomAnchor: NSLayoutYAxisAnchor)
    {
        self.leadingAnchor = leadingAnchor
        self.trailingAnchor = trailingAnchor
        self.topAnchor = topAnchor
        self.bottomAnchor = bottomAnchor
    }
}

extension UILayoutGuide  {
    var snappableLayoutGuide: SnappableLayoutGuide {
        return SnappableLayoutGuide(leadingAnchor: leadingAnchor,
                                    trailingAnchor: trailingAnchor,
                                    topAnchor: topAnchor,
                                    bottomAnchor: bottomAnchor)
    }
}

extension UIView {
    var baseSnappableLayoutGuide: SnappableLayoutGuide {
        let guide = SnappableLayoutGuide(leadingAnchor: leadingAnchor,
                                         trailingAnchor: trailingAnchor,
                                         topAnchor: topAnchor,
                                         bottomAnchor: bottomAnchor)
        return guide
    }
}

extension UIView {
    func snapTopBottom(to guide: SnappableLayoutGuideType) {
        self.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
    }
    
    func snapLeadTrail(to guide: SnappableLayoutGuideType) {
        self.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    }
    
    func snapAll(to guide: SnappableLayoutGuideType) {
        snapTopBottom(to: guide)
        snapLeadTrail(to: guide)
    }
    
    func snapTopBottomToSuperview() {
        guard let sv = self.superview
            else { return }
        
        snapTopBottom(to: sv.baseSnappableLayoutGuide)
    }
    
    func snapLeadTrailToSuperview() {
        guard let sv = self.superview
            else { return }
        
        snapLeadTrail(to: sv.baseSnappableLayoutGuide)
    }
    
    func snapAllToSuperview() {
        snapTopBottomToSuperview()
        snapLeadTrailToSuperview()
    }
    
    // MARK: safe area
    @available(iOS 11.0, *)
    func snapTopBottomToSuperviewSafeArea() {
        guard let sv = self.superview
            else { return }
        
        snapTopBottom(to: sv.safeAreaLayoutGuide.snappableLayoutGuide)
    }
    
    @available(iOS 11.0, *)
    func snapLeadTrailToSuperviewSafeArea() {
        guard let sv = self.superview
            else { return }
        
        snapLeadTrail(to: sv.safeAreaLayoutGuide.snappableLayoutGuide)
    }
    
    @available(iOS 11.0, *)
    func snapAllToSuperviewSafeArea() {
        snapTopBottomToSuperviewSafeArea()
        snapLeadTrailToSuperviewSafeArea()
    }
}
