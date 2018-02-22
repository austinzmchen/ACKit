//
//  ACHideableViewType.swift
//  ACKit
//
//  Created by Austin Chen on 2017-11-27.
//

import Foundation

public protocol ACHideableViewType {
    var defaultHeight: CGFloat { get }
    func setIsHidden(_ hidden: Bool, animated: Bool, completion: ((Bool) -> ())?)
}

extension ACView: ACHideableViewType {
    // MARK: instance methods
    
    override open var isHidden: Bool {
        set {
            guard newValue != isHidden else {
                return
            }
            
            guard let heightConstraint = constraints.front({$0.firstAttribute == .height})
                else { return }
            
            if isHidden {
                heightConstraint.constant = 0.0
            } else {
                heightConstraint.constant = defaultHeight
            }
            self.superview?.layoutIfNeeded()
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
        
        guard let heightConstraint = constraints.front({$0.firstAttribute == .height})
            else { return }
        
        if hidden {
            heightConstraint.constant = 0.0
        } else {
            heightConstraint.constant = defaultHeight
            super.isHidden = false
        }
        
        UIView.animate(withDuration: 0.4, animations: {
            self.superview?.layoutIfNeeded()
        }, completion: { (finished) in
            super.isHidden = hidden
            if let c = completion { c(finished) }
        })
    }
}
