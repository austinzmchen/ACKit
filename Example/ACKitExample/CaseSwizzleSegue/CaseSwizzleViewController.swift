//
//  CaseSwizzleViewController.swift
//  ACKit_Example
//
//  Created by Austin Chen on 2018-01-21.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import ACKit

class CaseSwizzleViewController : UIViewController {
    @IBAction func showButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "kPresentCaseSwizzleVC2") { (segue) in
            (segue.destination as? CaseSwizzleViewController2)?.data = "dd"
        }
    }
}

class CaseSwizzleViewController2 : UIViewController {
    var data: String?
    
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("data: \(data)")
    }
}
