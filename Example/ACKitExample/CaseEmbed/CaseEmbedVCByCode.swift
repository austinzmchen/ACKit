//
//  CaseEmbedVCByCode.swift
//  ACKit
//
//  Created by Austin Chen on 2017-09-28.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class CaseEmbedVCByCode: UIViewController {
    
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    
    /*
     1. need this method otherwise init() not works
     2. need to connect FileOwner's view to the Nib's mainView
     */
    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: "CaseEmbedVCByCode", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // need this otherwise it's using storyboard's view controller as prototype
        let nib = UINib(nibName: "CaseEmbedVCByCode", bundle: nil)
        view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    }
    
    // self.view translatesAutoresizingMaskIntoConstraints is always true disregard how self is initialized
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("translatesAutoresizingMaskIntoConstraints: \(view.translatesAutoresizingMaskIntoConstraints)")
    }
}
