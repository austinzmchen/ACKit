//
//  ACView.swift
//  <?>App
//
//  Created by Austin Chen on 2016-08-16.
//  Copyright © 2016 10.1. All rights reserved.
//

import UIKit

@IBDesignable
open class ACView: UIView {
    
    // MARK: hideable properties
    open var heightConstraint: NSLayoutConstraint?
    open var defaultHeight: CGFloat = 0
    
    // MARK: shadow
    
    @IBInspectable var shadowColor: UIColor? = nil
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0)
    @IBInspectable var shadowOpacity: CGFloat = 1.0
    @IBInspectable var shadowRadius: CGFloat = 0.0
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if let sc = self.shadowColor {
            // layer.masksToBounds = false
            layer.shadowColor = sc.cgColor
            layer.shadowOffset = self.shadowOffset
            layer.shadowOpacity = Float(self.shadowOpacity)
            layer.shadowRadius = self.shadowRadius
        }
    }
}
