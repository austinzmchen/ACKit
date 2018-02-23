//
//  ACRetractableView.swift
//  ACKit
//
//  Created by Austin Chen on 2017-09-05.
//  Copyright © 2017 Austin Chen. All rights reserved.
//

import UIKit
import ACKit

@IBDesignable
class ACRetractableView: ACView {
    @IBInspectable var retractTop: Bool = true // false for bottom retract
    
    @IBOutlet var contentView: UIView!
    
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
        insertSubview(contentView, at: 0)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // add the missing contrainst between xib contentView to self
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        if retractTop {
            contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        } else {
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        }
        contentView.constraints.front{$0.firstAttribute == .height}?.constant = normalHeight
        
        clipsToBounds = true
    }
}
