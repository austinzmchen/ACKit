//
//  UIImageView+EdgeInsets.swift
//  <?>App
//
//  Created by Austin Chen on 2016-09-01.
//  Copyright © 2016 10.1. All rights reserved.
//

import UIKit

@IBDesignable
extension UIImageView {
    @IBInspectable var edgeInsets: CGRect {
        set {
            let insets = UIEdgeInsets(top: newValue.origin.x,
                                      left: newValue.origin.y,
                                      bottom: newValue.size.width,
                                      right: newValue.size.height)
            layoutMargins = insets
        }
        get {
            let r = CGRect(x: layoutMargins.top,
                           y: layoutMargins.left,
                           width: layoutMargins.bottom,
                           height: layoutMargins.right)
            return r
        }
    }
}
