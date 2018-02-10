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
    
    @IBOutlet weak var showSegueButton: UIButton!
    
    // segueActionable
    @IBAction func showButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "kPresentCaseSwizzleVC2") { (segue) in
            (segue.destination as? CaseSwizzleViewController2)?.data = "dd1"
        }
    }
    
    // regular
    @IBAction func regularShowButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "kPresentCaseSwizzleVC2_regular", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showSegueButton.addAction(for: .touchUpInside) { sender in
            print("data2: \(sender)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "kPresentCaseSwizzleVC2_regular" {
            (segue.destination as? CaseSwizzleViewController2)?.data = "dd2"
        } else if segue.identifier == "kPresentCaseSwizzleVC2" {
            print("just loggin")
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
