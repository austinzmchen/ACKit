//
//  ACTriangleView.swift
//  ACKit
//
//  Created by Austin Chen on 2018-08-21.
//
import UIKit
import Foundation

@IBDesignable
class ACTriangleView: UIView {
    
    @IBInspectable var size: CGSize = CGSize.zero
    @IBInspectable var color: UIColor? = nil
    
    @IBInspectable var shadowColor: UIColor? = nil
    @IBInspectable var shadowOffset: CGSize = CGSize.zero
    @IBInspectable var shadowBlurRadius: CGFloat = 0
    
    override func draw(_ rect: CGRect) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = self.shadowColor
        shadow.shadowOffset = shadowOffset
        shadow.shadowBlurRadius = shadowBlurRadius
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 0))
        bezierPath.addLine(to: CGPoint(x: self.size.width, y: 0))
        
        /* let halfWidth: Float = Float(self.size.width) / 2.0
         let h: Float = powf(halfWidth, 2) -  powf(Float(self.size.height), 2)
         let sq = sqrtf(abs(h)) // pathogorian theorem */
        
        bezierPath.addLine(to: CGPoint(x: self.size.width / 2.0, y: self.size.height))
        bezierPath.addLine(to: CGPoint(x: 0, y: 0))
        bezierPath.close()
        context?.saveGState()
        context?.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
        self.color?.setFill()
        bezierPath.fill()
        context?.restoreGState()
        
        UIColor.white.setStroke()
        bezierPath.lineWidth = self.borderWidth
        bezierPath.stroke()
    }
}
