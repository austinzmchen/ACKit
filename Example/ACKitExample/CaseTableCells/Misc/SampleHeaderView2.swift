//
//  SampleHeaderView2.swift
//  ACKit
//
//  Created by Austin Chen on 2017-09-21.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

/*
 1. Nib's top level view must have a child container view to serve as UITableViewHeaderFooterView's "contentView"
 2. In UITableViewHeaderFooterView, make sure the background color is default. This is to avoid the warning Setting the background color on UITableViewHeaderFooterView has been deprecated.
 http://samwize.com/2015/11/06/guide-to-customizing-uitableview-section-header-footer/
 */
class SampleHeaderView2: UITableViewHeaderFooterView {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
}
