//
//  SampleNavFirstViewController.swift
//  ACKit
//
//  Created by Austin Chen on 2017-08-27.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class SampleNavFirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("SampleNavFirstViewController viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("SampleNavFirstViewController viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("SampleNavFirstViewController viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("SampleNavFirstViewController viewDidDisappear")
    }

}
