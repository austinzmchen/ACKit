//
//  ACTabHeaderCollectionCell.swift
//  ?<App>
//
//  Created by Austin Chen on 2017-04-03.
//  Copyright © 2017 Austin Chen. All rights reserved.
//

import UIKit

@IBDesignable
class ACTabHeaderCollectionCell: UICollectionViewCell {

    @IBOutlet weak var button: UIButton! // user interac turned off
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet var underlineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
