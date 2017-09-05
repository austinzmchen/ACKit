//
//  CaseParallaxMainViewController.swift
//  ACKit
//
//  Created by Austin Chen on 2017-08-31.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class CaseParallaxMainViewController: UIViewController {
    
    @IBOutlet weak var parallaxView: KCParallaxView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parallaxView.backgroundImageView.image = UIImage(named: "parallaxImage")
        parallaxView.parallaxScrollFactor = 0.5
    }
}

extension CaseParallaxMainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let rect = parallaxView.convert(parallaxView.bounds, to: self.view)
        parallaxView.adjustParallax(by: rect, onVisibleBounds: self.view.bounds)
    }

}
