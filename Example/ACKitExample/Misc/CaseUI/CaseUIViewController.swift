//
//  CaseUIViewController.swift
//  ACKit_Example
//
//  Created by Austin Chen on 2018-02-23.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class CaseUIViewController: UIViewController {
    
    @IBAction func toggleAlertButtonTapped(_ sender: Any) {
        retractableView.setIsHidden(!retractableView.isHidden, animated: true)
    }
    @IBOutlet weak var retractableView: ACRetractableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up
        retractableView.isHidden = true
    }
}
