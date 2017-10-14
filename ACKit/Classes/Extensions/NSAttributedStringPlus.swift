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
                            wholeAttributes: [String:AnyObject],
                            attributedPart: String,
                            partAttributes: [String:AnyObject]) -> NSAttributedString
    {
        let index = whole.index(ofSubstr: attributedPart) ?? 0
        
        let myMutableString = NSMutableAttributedString(string: whole, attributes: wholeAttributes)
        myMutableString.addAttributes(partAttributes, range: NSMakeRange(index, attributedPart.characters.count))
        return myMutableString
    }
    
    // MARK: convenience
    open class func attributesForSemiboldWhiteFont(_ fontSize: CGFloat) -> [String:AnyObject] {
        return NSAttributedString.attributesForFont(fontSize, weight: UIFontWeightSemibold, color: UIColor.white)
    }
    
    open class func attributesForSemiboldFont(_ fontSize: CGFloat, color: UIColor) -> [String:AnyObject] {
        return NSAttributedString.attributesForFont(fontSize, weight: UIFontWeightSemibold, color: color)
    }
    
    open class func attributesForRegularWhiteFont(_ fontSize: CGFloat) -> [String:AnyObject] {
        return NSAttributedString.attributesForFont(fontSize, weight: UIFontWeightRegular, color: UIColor.white)
    }
    
    open class func attributesForRegularFont(_ fontSize: CGFloat, color: UIColor) -> [String:AnyObject] {
        return NSAttributedString.attributesForFont(fontSize, weight: UIFontWeightRegular, color: color)
    }
    
    // MARK:
    open class func attributesForFont(_ fontSize: CGFloat, weight: CGFloat, color: UIColor) -> [String:AnyObject] {
        return [NSFontAttributeName : UIFont.gothamFont(ofSize: fontSize, weight: weight),
                NSForegroundColorAttributeName: color]
    }
}

extension NSMutableAttributedString {
    
    open func attribute(part:String, index:Int, partAttributes:[String:AnyObject]) {
        if (index + part.length < self.length) {
            self.addAttributes(partAttributes, range: NSMakeRange(index, part.characters.count))
        } else {
            print("NSAttributedStringPlus error adding attribute: out of bound")
        }
    }
}
