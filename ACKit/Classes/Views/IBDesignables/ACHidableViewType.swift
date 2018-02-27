//
//  ACHidableViewType.swift
//  ACKit
//
//  Created by Austin Chen on 2017-11-27.
//

import Foundation

public protocol ACHidableViewType {
    var normalHeight: CGFloat { get }
    func setIsHidden(_ hidden: Bool, animated: Bool, completion: ((Bool) -> ())?)
}

extension ACView: ACHidableViewType {
    // MARK: instance methods
    
    override open var isHidden: Bool {
        set {
            guard newValue != isHidden else {
                return
            }
            
            if let heightConstraint = constraints.front({$0.firstAttribute == .height}) {
                if newValue {
                    heightConstraint.constant = 0.0
                } else {
                    heightConstraint.constant = normalHeight
                }
                self.superview?.layoutIfNeeded()
            }
            
            super.isHidden = newValue
        }
        
        get { return super.isHidden }
    }
    
    // MARK: instance methods
    
    public func setIsHidden(_ hidden: Bool, animated: Bool, completion: ((Bool) -> ())? = nil) {
        guard hidden != self.isHidden else {
            return
        }
        
        guard animated else {
            self.isHidden = hidden
            if let c = completion { c(true) }
            return
        }
        
        if let heightConstraint = constraints.front({$0.firstAttribute == .height}) {
            if hidden {
                heightConstraint.constant = 0.0
            } else {
                heightConstraint.constant = normalHeight
                super.isHidden = false
            }
            
            UIView.animate(withDuration: 0.4, animations: {
                self.superview?.layoutIfNeeded()
            }, completion: { (finished) in
                super.isHidden = hidden
                completion.map{ $0(finished) }
            })
        } else {
            super.isHidden = hidden
            completion.map{ $0(true) }
        }
    }
}
