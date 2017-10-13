//
//  UILabelPlus.swift
//  SnackableTV
//
//  Created by Austin Chen on 2017-09-20.
//  Copyright © 2017 Austin Chen. All rights reserved.
//

import UIKit

extension UILabel {
    var attributedTextRaw: String? {
        get {
            return attributedText?.string
        }
        
        set {
            guard let atr = newValue,
                let at = attributedText, at.length > 0 else
            {
                return
            }
            
            let attributes = at.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, at.length))
            attributedText = NSAttributedString(string: atr, attributes: attributes)
        }
    }
}
