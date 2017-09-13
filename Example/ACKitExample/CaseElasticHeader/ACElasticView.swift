//
//  ACElasticView.swift
//  ACKit
//
//  Created by Austin Chen on 2017-09-05.
//  Copyright © 2017 Austin Chen. All rights reserved.
//

import UIKit

enum ACElasticViewStyle {
    case none
    case topFixed
    case centerFixed
}

enum ACElasticViewExpandStyle {
    case none
    case scale
    case bottomShift
}

class ACElasticView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var eView: UIView!
    
    @IBOutlet weak var eViewTopConstraint: NSLayoutConstraint!
    
    // used when SHIFTING expand/shrink
    @IBOutlet weak var eViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var eViewBottomConstraint: NSLayoutConstraint!
    
    // used when scale elasticity
    @IBOutlet weak var eViewCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var eViewEqualHeightToContentViewConstraint: NSLayoutConstraint!
    
    var maxExpandableHeight: CGFloat = kDefaultMaxExpandableHeight {
        didSet {
            eView.constraints.filter {$0.firstAttribute == .height}.first?.constant = maxExpandableHeight
            self.setNeedsUpdateConstraints()
        }
    }
    
    var minExpandableHeight: CGFloat = 0
    
    // MARK: life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    func loadNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let contentView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        self.addSubview(contentView)
        
        // add the missing contrainst between xib contentView to self
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.clipsToBounds = true // in scale expand style, elastic view does not go out of bound of the container view
        maxExpandableHeight = kDefaultMaxExpandableHeight
        
        elasticStyle = .centerFixed // default to centerFixed
        expandStyle = .bottomShift
    }
    
    // MARK: elastic settings
    
    var elasticStyle: ACElasticViewStyle = .topFixed {
        didSet {
            switch elasticStyle {
            case .none:
                eViewTopConstraint.priority = 999
                eViewHeightConstraint.priority = 999
                eViewEqualHeightToContentViewConstraint.priority = 1
                eViewCenterYConstraint.priority = 1
            case .topFixed:
                eViewTopConstraint.priority = 999
                eViewCenterYConstraint.priority = 1
            case .centerFixed:
                eViewTopConstraint.priority = 1
                eViewCenterYConstraint.priority = 999
            }
            
            setNeedsUpdateConstraints()
        }
    }
    
    var elasticZoomConstant: CGFloat = 0 {
        didSet {
            if case .none = elasticStyle { return }
            
            eViewEqualHeightToContentViewConstraint.constant = elasticZoomConstant
        }
    }
    
    // MARK: expand settings
    
    var expandStyle: ACElasticViewExpandStyle = .bottomShift
    
    var cHeight: CGFloat = kDefaultMaxExpandableHeight {
        didSet {
            if cHeight >= maxExpandableHeight { // elasticity
                // turn off shift
                eViewBottomConstraint.priority = 1
                eViewHeightConstraint.priority = 1
                
                // turn on scale
                eViewEqualHeightToContentViewConstraint.priority = 999
                
            } else { // expand & shrink
                switch expandStyle {
                case .none:
                    eViewTopConstraint.priority = 999
                    eViewHeightConstraint.priority = 999
                    
                    eViewBottomConstraint.priority = 1
                    eViewEqualHeightToContentViewConstraint.priority = 1
                case .scale:
                    eViewBottomConstraint.priority = 1
                    eViewHeightConstraint.priority = 1
                    
                    eViewEqualHeightToContentViewConstraint.priority = 999
                case .bottomShift:
                    // turn on shift
                    eViewBottomConstraint.priority = 999
                    eViewHeightConstraint.priority = 999
                    
                    // turn off scale
                    eViewEqualHeightToContentViewConstraint.priority = 1
                }
            }
            
            let h = constraints.filter{ $0.firstAttribute == .height }.first
            h?.constant = cHeight
        }
    }
    
    var cOffsetY: CGFloat = 0 {
        didSet {
            if cOffsetY > 0 {
                cHeight = maxExpandableHeight - min(maxExpandableHeight - minExpandableHeight, cOffsetY)
            } else {
                cHeight = maxExpandableHeight
            }
        }
    }
}

fileprivate var kDefaultMaxExpandableHeight: CGFloat = 300
