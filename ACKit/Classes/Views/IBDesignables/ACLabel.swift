//
//  ACLabel.swift
//  <?>App
//
//  Created by Austin Chen on 2016-08-12.
//  Copyright © 2016 10.1. All rights reserved.
//

import UIKit

@IBDesignable
open class ACLabel: UILabel {
    
    // @IBInspectable UIEdgeInsets is not supported yet, so workaround like below
    @IBInspectable var textInsets: CGRect = CGRect()
    
    // to add a content insets
    override open func draw(_ rect: CGRect) {
        let insets = UIEdgeInsets(top: textInsets.origin.x,
                                  left: textInsets.origin.y,
                                  bottom: textInsets.size.width,
                                  right: textInsets.size.height)
        self.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
}
