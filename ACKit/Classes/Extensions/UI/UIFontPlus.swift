//
//  UIFontPlus.swift
//  SnackableTV
//
//  Created by Austin Chen on 2017-04-17.
//  Copyright © 2017 Austin Chen. All rights reserved.
//

import Foundation

public extension UIFont {
    enum ACCustomFontFamily: String {
        case titillium = "Titillium"
    }
    
    public class func customFont(ofFamily family: ACCustomFontFamily, size fontSize: CGFloat, weight: UIFont.Weight? = nil) -> UIFont {
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
        return UIFont(name: "\(family.rawValue.capitalized)-" + weightStr, size: fontSize)!
    }
}
