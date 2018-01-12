//
//  NSAttributedStringPlus.swift
//  <?>App
//
//  Created by Austin Chen on 2016-10-11.
//  Copyright © 2016 10.1. All rights reserved.
//

import Foundation

extension NSAttributedString {
    
    open class func wholeWithPart(whole: String,
                            wholeAttributes: [NSAttributedStringKey: AnyObject],
                            attributedPart: String,
                            partAttributes: [NSAttributedStringKey: AnyObject]) -> NSAttributedString
    {
        let index = whole.index(ofSubstr: attributedPart) ?? 0
        
        let myMutableString = NSMutableAttributedString(string: whole, attributes: wholeAttributes)
        myMutableString.addAttributes(partAttributes, range: NSMakeRange(index, attributedPart.characters.count))
        return myMutableString
    }
    
    // MARK: convenience
    open class func attributesForSemiboldWhiteFont(_ fontSize: CGFloat) -> [NSAttributedStringKey: AnyObject] {
        return NSAttributedString.attributesForFont(fontSize, weight: UIFont.Weight.semibold, color: UIColor.white)
    }
    
    open class func attributesForSemiboldFont(_ fontSize: CGFloat, color: UIColor) -> [NSAttributedStringKey: AnyObject] {
        return NSAttributedString.attributesForFont(fontSize, weight: UIFont.Weight.semibold, color: color)
    }
    
    open class func attributesForRegularWhiteFont(_ fontSize: CGFloat) -> [NSAttributedStringKey: AnyObject] {
        return NSAttributedString.attributesForFont(fontSize, weight: UIFont.Weight.regular, color: UIColor.white)
    }
    
    open class func attributesForRegularFont(_ fontSize: CGFloat, color: UIColor) -> [NSAttributedStringKey: AnyObject] {
        return NSAttributedString.attributesForFont(fontSize, weight: UIFont.Weight.regular, color: color)
    }
    
    // MARK:
    open class func attributesForFont(_ fontSize: CGFloat, weight: UIFont.Weight, color: UIColor) -> [NSAttributedStringKey: AnyObject] {
        return [NSAttributedStringKey.font : UIFont.systemFont(ofSize: fontSize, weight: weight),
                NSAttributedStringKey.foregroundColor: color]
    }
}

extension NSMutableAttributedString {
    
    open func attribute(part:String, index:Int, partAttributes:[NSAttributedStringKey: AnyObject]) {
        if (index + part.length < self.length) {
            self.addAttributes(partAttributes, range: NSMakeRange(index, part.characters.count))
        } else {
            print("NSAttributedStringPlus error adding attribute: out of bound")
        }
    }
}
