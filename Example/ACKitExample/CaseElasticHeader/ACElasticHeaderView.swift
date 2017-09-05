//
//  ACElasticHeaderView.swift
//  SampleScaleUpHeader
//
//  Created by Austin Chen on 2017-09-05.
//  Copyright © 2017 Austin Chen. All rights reserved.
//

import UIKit

enum ACElasticHeaderStyle {
    case topFixed
    case centerFixed
}

class ACElasticHeaderView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var centerYConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgViewEqualHeightToContentViewConstraint: NSLayoutConstraint!
    
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
        let nib = UINib(nibName: "ACElasticHeaderView", bundle: bundle)
        let contentView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        self.addSubview(contentView)
        
        // add the missing contrainst between xib contentView to self
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.clipsToBounds = true
        elasticStyle = .topFixed // default to topFixed
    }
    
    var elasticStyle: ACElasticHeaderStyle = .topFixed {
        didSet {
            switch elasticStyle {
            case .topFixed:
                topConstraint.priority = 1000 // required
                centerYConstraint.priority = 999 // optional
            case .centerFixed:
                topConstraint.priority = 999
                centerYConstraint.priority = 1000
            }
            
            setNeedsUpdateConstraints()
        }
    }
    
    var elasticZoomConstant: CGFloat = 0 {
        didSet {
            imgViewEqualHeightToContentViewConstraint.constant = elasticZoomConstant
        }
    }
        
    var heightConstraint: NSLayoutConstraint? {
        return self.constraints.filter{ $0.firstAttribute == .height }.first
    }
    
}
