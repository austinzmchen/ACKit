//
//  SampleTableViewCell2.swift
//  ACKit
//
//  Created by Austin Chen on 2017-08-24.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class SampleTableViewCell2: UITableViewCell {

    @IBOutlet var view: UIView!
    
    // MARK: life cycles
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    func loadNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "SampleTableViewCell2", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        self.contentView.addSubview(view)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // add the missing contrainst between xib contentView to self
        view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        view.translatesAutoresizingMaskIntoConstraints = false // necessary
        view.setNeedsUpdateConstraints()
    }
    
}
