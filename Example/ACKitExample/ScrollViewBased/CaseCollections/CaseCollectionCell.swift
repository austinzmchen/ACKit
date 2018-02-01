//
//  CaseCollectionCell.swift
//  ACKit_Example
//
//  Created by Austin Chen on 2018-01-30.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class CaseCollectionCell: UICollectionViewCell {
    
    // compare hightlight between tableView and colletionView
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                UIView.animate(withDuration: 0.1, animations: {
                    self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                })
            } else {
                UIView.animate(withDuration: 0.1, animations: {
                    self.transform = CGAffineTransform.identity
                })
            }
        }
    }
}
