//
//  CaseStackViewController.swift
//  ACKit_Example
//
//  Created by Austin Chen on 2018-02-22.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import ACKit

class CaseStackViewController: UIViewController {
    
    @IBOutlet weak var stackView1: UIStackView!
    @IBOutlet weak var stackView2: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (stackView2.arrangedSubviews[0] as? ACView)?.intrinsicHeight = 30
        (stackView2.arrangedSubviews[1] as? ACView)?.intrinsicHeight = (270 - 30) / 2.0
        (stackView2.arrangedSubviews[2] as? ACView)?.intrinsicHeight = (270 - 30) / 2.0
    }
}
