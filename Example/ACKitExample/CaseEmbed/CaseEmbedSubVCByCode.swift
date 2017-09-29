//
//  CaseEmbedSubVCByCode.swift
//  ACKit
//
//  Created by Austin Chen on 2017-09-28.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class CaseEmbedSubVCByCode: CaseEmbedVCByCode {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // embed
        let controller = CaseEmbedVCByCode()
        addChildViewController(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        view2.addSubview(controller.view)
        
        NSLayoutConstraint.activate([
            controller.view.leadingAnchor.constraint(equalTo: view2.leadingAnchor, constant: 0),
            controller.view.trailingAnchor.constraint(equalTo: view2.trailingAnchor, constant: 0),
            controller.view.topAnchor.constraint(equalTo: view2.topAnchor, constant: 0),
            controller.view.bottomAnchor.constraint(equalTo: view2.bottomAnchor, constant: 0)
        ])
        controller.didMove(toParentViewController: self)
        
        // customize
        controller.view1.backgroundColor = UIColor.blue
    }
}
