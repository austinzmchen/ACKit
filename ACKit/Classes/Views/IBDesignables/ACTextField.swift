//
//  ACTextField.swift
//  <?>App
//
//  Created by Austin Chen on 2016-08-12.
//  Copyright © 2016 10.1. All rights reserved.
//

import UIKit

@IBDesignable
open class ACTextField: UITextField {
    
    // @IBInspectable UIEdgeInsets is not supported yet, so workaround like below
    @IBInspectable open var textInsets: CGRect = CGRect()
    
    // placeholder position
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: textInsets.origin.y, dy: textInsets.size.height);
    }
    
    // text position
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: textInsets.origin.y, dy: textInsets.size.height);
    }
    
    @IBInspectable open var placeholderFontColor: UIColor?
    @IBInspectable open var placeholderFontSize: CGFloat = 0
    private var isAttributedPlaceholderSet = false // prevent repeated setting placehoder, as it causes crash for ios 9
    
    // MARK: life cycle 
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if !isAttributedPlaceholderSet,
            let ph = self.placeholder,
            let phc = placeholderFontColor
        {
            self.attributedPlaceholder = NSAttributedString(string: ph, attributes:
                [NSAttributedStringKey.font : UIFont.systemFont(ofSize: placeholderFontSize, weight: UIFont.Weight.regular),
                 NSAttributedStringKey.foregroundColor: phc])
            isAttributedPlaceholderSet = true
        }
    }
}
