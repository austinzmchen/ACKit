//
//  UIButton.swift
//  SnackableTV
//
//  Created by Austin Chen on 2017-11-27.
//  Copyright © 2017 Austin Chen. All rights reserved.
//

import Foundation

extension UIButton {
    
    // @IBInspectable UIEdgeInsets is not supported yet, so workaround like below
    @IBInspectable open var textInsets: CGRect {
        set {
            let insets = UIEdgeInsets(top: newValue.origin.x,
                                      left: newValue.origin.y,
                                      bottom: newValue.size.width,
                                      right: newValue.size.height)
            contentEdgeInsets = insets
        }
        
        get {
            let r = CGRect(x: contentEdgeInsets.top,
                           y: contentEdgeInsets.left,
                           width: contentEdgeInsets.bottom,
                           height: contentEdgeInsets.right)
            return r
        }
    }
}
