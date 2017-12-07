//
//  UIView+Border.swift
//  SnackableTV
//
//  Created by Austin Chen on 2017-11-27.
//  Copyright © 2017 Austin Chen. All rights reserved.
//

import Foundation

@IBDesignable
public extension UIView {
    @IBInspectable
    public var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable
    public var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable
    public var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            if let c = layer.borderColor {
                return UIColor(cgColor: c)
            }
            return nil
        }
    }
}
