//
//  UIFontPlus.swift
//  SnackableTV
//
//  Created by Austin Chen on 2017-04-17.
//  Copyright © 2017 Austin Chen. All rights reserved.
//

import Foundation

extension UIFont {
    
    open class func montserratFont(ofSize fontSize: CGFloat, weight: UIFont.Weight? = nil) -> UIFont {
        var weightStr = "Regular"
        if let w = weight {
            switch w {
            case .ultraLight:
                weightStr = "UltraLight"
            case .thin:
                weightStr = "Thin"
            case .light:
                weightStr = "Light"
            case .regular:
                weightStr = "Regular"
            case .medium:
                weightStr = "Medium"
            case .semibold:
                weightStr = "Semibold"
            case .bold:
                weightStr = "Bold"
            case .black:
                weightStr = "Black"
            default:
                break
            }
        }
        return UIFont(name: "Montserrat-" + weightStr, size: fontSize)!
    }
    
    open class func gothamFont(ofSize fontSize: CGFloat, weight: UIFont.Weight? = nil) -> UIFont {
        var weightStr = "Regular"
        if let w = weight {
            switch w {
            case .regular:
                weightStr = "Book" //"Regular"
            case .bold:
                weightStr = "Bold"
            case .light:
                weightStr = "Light"
            case .medium:
                weightStr = "Medium"
            default:
                break
            }
        }
        return UIFont(name: "Gotham-" + weightStr, size: fontSize)!
    }
}
