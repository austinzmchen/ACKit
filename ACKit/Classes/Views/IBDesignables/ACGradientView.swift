//
//  ACGradientView.swift
//  <?>App
//
//  Created by Austin Chen on 2016-08-15.
//  Copyright © 2016 10.1. All rights reserved.
//

import UIKit


@IBDesignable
open class ACGradientView: ACView {
    
    public enum GradientDirection {
        case vertical
        case horizontal
        case diagonal
    }
    
    @IBInspectable open var colorA: UIColor?
    @IBInspectable open var colorB: UIColor?
    @IBInspectable open var vertical: Bool = true

    /// Set this gradient direction in viewWillAppear or similar, before the view has displayed. Defaults to vertical.
    public var gradientDirection: GradientDirection? = .vertical {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /* https://stackoverflow.com/a/13429206
     With CALayers (the CA stands for core animation...) any change to an animatable property will be animated by default. This is called implicit animation. The default animation takes 0.25 seconds, so if you are updating it frequently, say during processing of touches, this will add up and cause a visible lag.
     */
    @IBInspectable open var disableImplicitLayerAnimation: Bool = false
    
    var gradientLayer = CAGradientLayer()
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if disableImplicitLayerAnimation {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            gradientLayer.frame = self.bounds;
            CATransaction.commit()
            return
        }
        gradientLayer.frame = self.bounds;
    }
    
    override open func draw(_ rect: CGRect) {
        // remove sublayers
        gradientLayer.removeFromSuperlayer()
        
        // set up header view
        gradientLayer.frame = self.bounds;
        
        // let gradientDirection override vertical
        if let gd = gradientDirection {
            switch gd {
            case .horizontal:
                drawHorizontal()
            case .diagonal:
                drawDiagonal()
            default:
                drawVertical()
            }
        } else {
            if vertical {
                drawVertical()
            } else {
                drawHorizontal()
            }
        }
        
        var gradientColors: [AnyObject] = []
        if let cA = self.colorA {
            gradientColors.append(cA.cgColor)
        }
        if let cB = self.colorB {
            gradientColors.append(cB.cgColor)
        }
        gradientLayer.colors = gradientColors
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension ACGradientView {
    
    func drawVertical() {
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
    }
    
    func drawHorizontal() {
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5) // mid left
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5) // mid right
    }
    
    func drawDiagonal() {
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
    }
    
}


