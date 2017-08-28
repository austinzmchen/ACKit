//
//  CaseUIViewWillMoveViewController1.swift
//  ACKit
//
//  Created by Austin Chen on 2017-08-27.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class CaseUIViewWillMoveViewController1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    open override func loadView() {
        view = CaseWillMoveView()
    }

}
