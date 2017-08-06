//
//  ACBorderedButton.swift
//  <?>App
//
//  Created by Austin Chen on 2016-08-12.
//  Copyright © 2016 10.1. All rights reserved.
//

import UIKit

@IBDesignable
open class ACBorderedButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    // override cornerRadius to allow resizable circular corner, eg percentage based constraint for height
    @IBInspectable var circularCorner: Bool = false
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    // @IBInspectable UIEdgeInsets is not supported yet, so workaround like below
    @IBInspectable var textInsets: CGRect = CGRect() {
        didSet {
            let insets = UIEdgeInsets(top: textInsets.origin.x,
                                      left: textInsets.origin.y,
                                      bottom: textInsets.size.width,
                                      right: textInsets.size.height)
            self.contentEdgeInsets = insets
        }
    }

    open var bgColor: UIColor? = nil
    @IBInspectable open var hightlightBGColor: UIColor?
    
    override open var isHighlighted: Bool {
        didSet {
            if let c = self.hightlightBGColor {
                if isHighlighted {
                    if self.bgColor == nil { // avoid being set to new hight light bg color
                        self.bgColor = self.backgroundColor
                    }
                    self.backgroundColor = c
                } else {
                    self.backgroundColor = bgColor
                }
            }
        }
    }
    
    // MARK: overrides 
    open override var isEnabled: Bool {
        didSet {
            if isEnabled {
                self.alpha = 1.0
            } else {
                self.alpha = 0.5
            }
        }
    }
    
    // MARK: life cycle
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        if circularCorner {
            self.cornerRadius = self.bounds.height / 2.0 // radius == half height, for circular corner
        }
    }
    
}
