//
//  ACShadowView.swift
//  <?>App
//
//  Created by Austin Chen on 2016-09-29.
//  Copyright © 2016 10.1. All rights reserved.
//

import UIKit

/*
 for starters, set shadowColor, shadowBlurRadius
 foregroundColor replaces self.backgroundColor
 */

/**
    this view contains a child view which can create a border around itself.
    the reason for creating a child view is the fact that masksToBounds needs to be one value for creating a border, while being the opposite value for having a shadow.
 
    Note: self.backgroundColor is hardcoded to be clear, even though it is stated differently on storyboard
    Ref: http://stackoverflow.com/a/34984063
 */
@IBDesignable
open class ACShadowView: UIView {

    @IBInspectable open var foregroundColor: UIColor? = nil
    
    @IBInspectable open var _borderColor: UIColor? = nil
    @IBInspectable open var _borderWidth: CGFloat = 0
    @IBInspectable open var _cornerRadius: CGFloat = 0
    
    @IBInspectable open var shadowColor: UIColor? = nil
    @IBInspectable open var shadowOffset: CGSize = CGSize.zero
    @IBInspectable open var shadowRadius: CGFloat = 0
    @IBInspectable open var shadowOpacity: CGFloat = 1
    
    private var borderView = UIView()

    override open func layoutSubviews() {
        super.layoutSubviews()
        
        // add the shadow to the base view
        self.backgroundColor = UIColor.clear
        self.layer.shadowColor = shadowColor?.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = Float(shadowOpacity)
        self.layer.shadowRadius = shadowRadius
        self.layer.masksToBounds = false
        
        if borderView.superview == nil {
            borderView.frame = self.bounds
            borderView.backgroundColor = foregroundColor
            borderView.layer.cornerRadius = _cornerRadius
            borderView.layer.borderColor = _borderColor?.cgColor
            borderView.layer.borderWidth = _borderWidth
            borderView.layer.masksToBounds = true
            self.addSubview(borderView)
        }
        
        // Adding rounded corners and shadows can be a performance hit. You can improve performance by using a predefined path for the shadow and also specifying that it be rasterized. The following code can be added to the example above.
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: _cornerRadius).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
