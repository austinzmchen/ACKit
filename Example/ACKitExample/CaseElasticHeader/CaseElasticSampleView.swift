//
//  CaseElasticSampleView.swift
//  ACKit
//
//  Created by Austin Chen on 2017-09-05.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class CaseElasticSampleView: ACElasticView {
    
    @IBOutlet var subContentView: UIView!
    
    override func loadNib() {
        super.loadNib()
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CaseElasticSampleView", bundle: bundle)
        let subContentView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        self.eView.addSubview(subContentView)
        
        // add the missing contrainst between xib contentView to self
        subContentView.translatesAutoresizingMaskIntoConstraints = false
        subContentView.leadingAnchor.constraint(equalTo: eView.leadingAnchor).isActive = true
        subContentView.trailingAnchor.constraint(equalTo: eView.trailingAnchor).isActive = true
        subContentView.topAnchor.constraint(equalTo: eView.topAnchor).isActive = true
        subContentView.bottomAnchor.constraint(equalTo: eView.bottomAnchor).isActive = true
    }
}
    
