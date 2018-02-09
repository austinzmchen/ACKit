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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainScrollView.delegate = self
        
        elasticView1.maxExpandableHeight = 300
        elasticView1.minExpandableHeight = 100
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let tv = (accountPageViewController.orderedViewControllers[0] as! CaseElastic3SubVC1).tableView!
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
        if pageIndex == 0 {
            let vc = viewController.orderedViewControllers[pageIndex] as! CaseElastic3SubVC1
            containerView.constraints.filter{$0.firstAttribute == .height}.first?.constant = vc.tableView.contentSize.height
        } else {
            let vc = viewController.orderedViewControllers[pageIndex] as! CaseElastic3SubVC2
            containerView.constraints.filter{$0.firstAttribute == .height}.first?.constant = vc.tableView.contentSize.height
        }
    }
    
    func didUpdate(pageCount: Int, viewController: CaseElastic3PageViewController) {
    }
}

extension CaseElastic3ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
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
