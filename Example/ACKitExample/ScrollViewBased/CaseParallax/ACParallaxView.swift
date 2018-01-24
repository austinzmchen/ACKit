//
//  ACParallaxView.swift
//  ACKit
//
//  Created by Austin Chen on 2017-08-31.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class ACParallaxView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet private weak var imgView: UIImageView!
    @IBOutlet weak var imgCenterYConstraint: NSLayoutConstraint!
    
    var imgWidthConstraint: NSLayoutConstraint?
    var imgHeightConstraint: NSLayoutConstraint?
    
    // MARK: life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // add the missing contrainst between xib contentView to self
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        imgWidthConstraint = imgView.widthAnchor.constraint(equalToConstant: 0)
        imgHeightConstraint = imgView.heightAnchor.constraint(equalToConstant: 0)
    }
    
    var image: UIImage? {
        didSet {
            guard let img = image
                else { return }
            
            imgView.image = img
            
            imgWidthConstraint?.constant = img.size.width
            imgHeightConstraint?.constant = img.size.height
            imgView.setNeedsUpdateConstraints()
        }
    }
    
    var offsetRatio: Float = 0 {
        didSet {
            
        }
    }
}
