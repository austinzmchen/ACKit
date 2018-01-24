//
//  CaseBlurModalMainViewController.swift
//  ACKit_Example
//
//  Created by Austin Chen on 2017-10-05.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class CaseBlurModalMainViewController: UIViewController {
    
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet var blurSlider: UISlider!
    
    @IBAction func blurSliderValueChanged(_ sender: Any) {
        guard let s = sender as? UISlider
            else { return }
        blurView.alpha = CGFloat(s.value)
    }
}
