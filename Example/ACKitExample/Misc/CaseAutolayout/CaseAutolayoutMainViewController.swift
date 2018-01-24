//
//  CaseAutolayoutMainViewController.swift
//  ACKit
//
//  Created by Austin Chen on 2017-08-29.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class CaseAutolayoutMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false // default to true if created programmatically
        v.backgroundColor = UIColor.yellow
        view.addSubview(v)
        
        v.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        v.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        v.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100).isActive = true
        v.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100).isActive = true
    }
}
