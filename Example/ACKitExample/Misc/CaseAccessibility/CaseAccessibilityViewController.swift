//
//  CaseAccessibilityViewController.swift
//  ACKit_Example
//
//  Created by Austin Chen on 2018-01-29.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class CaseAccessibilityViewController: UIViewController {
    
    @IBOutlet weak var containerView1: CaseAccessibilityView!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var label2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView1.label1 = label1
        containerView1.button3 = button3
        containerView1.label2 = label2
    }
}
