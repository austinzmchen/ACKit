//
//  CaseProxySelector.swift
//  ACKit_Example
//
//  Created by Austin Chen on 2018-02-10.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

class CaseProxySelector: UIViewController {
    @IBOutlet weak var button1: UIButton!
    
    // segueActionable
    @IBAction func button1Tapped(_ sender: Any) {
        print("button 1 tapped: \(sender)")
    }
    
    // regular
    @IBAction func button2Tapped(_ sender: Any) {
        print("button 2 tapped: \(sender)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.addAction(for: .touchUpInside) { sender in
            print("button 1 action tapped: \(sender)")
        }
    }
}
