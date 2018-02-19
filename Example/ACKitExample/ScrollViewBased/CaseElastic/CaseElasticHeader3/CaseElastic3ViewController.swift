//
//  CaseElastic3ViewController.swift
//  MBNA
//
//  Created by Austin Chen on 2017-12-14.
//  Copyright © 2017 Austin Chen. All rights reserved.
//

import UIKit
import ACKit

class CaseElastic3ViewController: UIViewController {
    
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var elasticView1: ElasticView!
    @IBOutlet weak var containerView: UIView!
    
    private var accountPageViewController: CaseElastic3PageViewController!
    private var pageIdx = 0
    
    private var ac = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainScrollView.delegate = self
        mainScrollView.alwaysBounceVertical = true
        
        elasticView1.maxExpandableHeight = 300
        elasticView1.minExpandableHeight = 100
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let tv = (accountPageViewController.orderedViewControllers[self.pageIdx] as! CaseElastic3SubVCType).tableView!
        print("cs1: \(tv.contentSize)")
        containerView.constraints.filter{$0.firstAttribute == .height}.first?.constant = tv.contentSize.height
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedVC" {
            accountPageViewController = segue.destination as! CaseElastic3PageViewController
            accountPageViewController.apDelegate = self
        }
    }
}

extension CaseElastic3ViewController: CE3PageViewControllerDelegate {
    func didUpdate(pageIndex: Int, viewController: CaseElastic3PageViewController) {
        self.pageIdx = pageIndex
        
        let vc = viewController.orderedViewControllers[self.pageIdx] as! CaseElastic3SubVCType
        let tHeight = vc.tableView.contentSize.height
        guard let containerViewHeight = containerView.constraints.filter({$0.firstAttribute == .height}).first else { return }
        
        if containerViewHeight.constant > tHeight {
//            var y: CGFloat = mainScrollView.contentOffset.y - (containerViewHeight.constant - tHeight)
//            y = max(y, 0)
//            let yPoint = CGPoint(x: mainScrollView.contentOffset.x, y: y)
//            mainScrollView.setContentOffset(yPoint, animated: true)
            if pageIndex == 1 { ac = true }
            
            self.containerView.superview?.layoutIfNeeded()
            containerViewHeight.constant = tHeight
            UIView.animate(withDuration: 0.5, animations: {
                self.containerView.superview?.layoutIfNeeded()
            })
        } else {
            containerViewHeight.constant = tHeight
        }
        
        print("height: \(vc.tableView.contentSize.height)")
    }
    
    func didUpdate(pageCount: Int, viewController: CaseElastic3PageViewController) {
    }
}

extension CaseElastic3ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if ac { return }
        
        // add expanding
        let offsetY = scrollView.contentOffset.y
        elasticView1.cOffsetY = offsetY
        
        // add elasticity
        if scrollView.contentOffset.y < 0 {
            let y = abs(scrollView.contentOffset.y)
            
            elasticView1.elasticZoomConstant = y
        }
    }
}
