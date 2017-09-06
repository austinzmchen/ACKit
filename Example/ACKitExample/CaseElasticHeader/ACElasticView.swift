//
//  ACElasticView.swift
//  ACKit
//
//  Created by Austin Chen on 2017-09-05.
//  Copyright © 2017 Austin Chen. All rights reserved.
//

import UIKit

enum ACElasticViewStyle {
    case topFixed
    case centerFixed
}

enum ACElasticViewExpandStyle {
    case scale
    case bottomShift
}

class ACElasticView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var eView: UIView!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    // used when SHIFTING expand/shrink
    @IBOutlet weak var eViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    // used when scale elasticity
    @IBOutlet weak var centerYConstraint: NSLayoutConstraint!
    @IBOutlet weak var elasticViewEqualHeightToContentViewConstraint: NSLayoutConstraint!
    
    static var maxExpandableHeight: CGFloat {
        return 200
    }
    
    static var expandableLimit: CGFloat {
        return 50
    }
    
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
        let nib = UINib(nibName: "ACElasticView", bundle: bundle)
        let contentView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        self.addSubview(contentView)
        
        // add the missing contrainst between xib contentView to self
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.clipsToBounds = true // in scale expand style, elastic view does not go out of bound of the container view
        elasticStyle = .topFixed // default to centerFixed
        expandStyle = .bottomShift
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
    
    // MARK: elastic settings
    
    var elasticStyle: ACElasticViewStyle = .topFixed {
        didSet {
            switch elasticStyle {
            case .topFixed:
                topConstraint.priority = 999
                centerYConstraint.priority = 1
            case .centerFixed:
                topConstraint.priority = 1
                centerYConstraint.priority = 999
            }
            
            setNeedsUpdateConstraints()
        }
    }
    
    var elasticZoomConstant: CGFloat = 0 {
        didSet {
            elasticViewEqualHeightToContentViewConstraint.constant = elasticZoomConstant
        }
    }
    
    // MARK: expand settings
    
    var expandStyle: ACElasticViewExpandStyle = .bottomShift
    
    var cHeight: CGFloat = ACElasticView.maxExpandableHeight {
        didSet {
            if cHeight >= ACElasticView.maxExpandableHeight { // elasticity
                // turn off shift
                bottomConstraint.priority = 1
                eViewHeightConstraint.priority = 1
                
                // turn on scale
                elasticViewEqualHeightToContentViewConstraint.priority = 999
                
            } else { // expand & shrink
                if case .bottomShift = expandStyle {
                    // turn on shift
                    bottomConstraint.priority = 999
                    eViewHeightConstraint.priority = 999
                    
                    // turn off scale
                    elasticViewEqualHeightToContentViewConstraint.priority = 1
                } else {
                    bottomConstraint.priority = 1
                    eViewHeightConstraint.priority = 1
                    
                    elasticViewEqualHeightToContentViewConstraint.priority = 999
                }
            }
            
            let h = constraints.filter{ $0.firstAttribute == .height }.first
            h?.constant = cHeight
        }
    }
}
