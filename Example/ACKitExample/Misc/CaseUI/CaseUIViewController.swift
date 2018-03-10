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
    @IBAction func buttonTapped(_ sender: Any) {
        performSegue(withIdentifier: "kCaseUIOverCurrentContext", sender: nil)
    }
    @IBOutlet weak var retractableView: ACRetractableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up
        retractableView.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        if #available(iOS 11, *) {
            print("ac1: \(view.safeAreaInsets)") // affected by navigation bar
            
            // not affected by any navigation bars / toolbars / tab bars. All non-notch devices are guaranteed to have zero safeAreaInsets at the screen level.
            print("ac2: \(sharedAppDelegate.window?.safeAreaInsets)")
        }
    }
}
