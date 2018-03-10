//
//  CaseiPhoneXViewController.swift
//  ACKit_Example
//
//  Created by Austin Chen on 2018-03-09.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class CaseiPhoneXViewController: UIViewController {
    
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var headerView: UIView!
    @IBAction func toggleHeaderButton(_ sender: Any) {
        isTopBarShown = !isTopBarShown
    }
    
    @IBAction func toggleBottomButton(_ sender: Any) {
        isFooterShown = !isFooterShown
    }
    @IBOutlet weak var bottomView: UIView!
    
    var isTopBarShown: Bool = true {
        didSet {
            if isTopBarShown {
                view.constraints.first{$0.identifier == "kHeaderConstraintBottom"}?.constant = 44
            } else {
                var t: CGFloat = 0
                if #available(iOS 11, *) {
                    t = view.safeAreaInsets.top
                } else {
                    t = view.layoutMargins.top
                }
                view.constraints.first{$0.identifier == "kHeaderConstraintBottom"}?.constant = -t
            }
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    var isFooterShown: Bool = true {
        didSet {
            if isFooterShown {
                view.constraints.first{$0.identifier == "kFooterCstTop"}?.constant = 44
            } else {
                var t: CGFloat = 0
                if #available(iOS 11, *) {
                    t = view.safeAreaInsets.bottom
                } else {
                    t = view.layoutMargins.top
                }
                view.constraints.first{$0.identifier == "kFooterCstTop"}?.constant = -t
            }
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
