//
//  CaseElastic3ViewController.swift
//  <?>App
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
    
    private var pageViewController: ACPageViewController!
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
        
        let tv = (pageViewController.orderedViewControllers[self.pageIdx] as! CaseElastic3SubVCType).tableView!
        print("cs1: \(tv.contentSize)")
        containerView.constraints.filter{$0.firstAttribute == .height}.first?.constant = tv.contentSize.height
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedVC" {
            pageViewController = segue.destination as! ACPageViewController
            let subVC1 =  storyboard?.instantiateViewController(withIdentifier: "subVC1") as! CaseElastic3SubVC1
            let subVC2 =  storyboard?.instantiateViewController(withIdentifier: "subVC2") as! CaseElastic3SubVC2
            pageViewController.orderedViewControllers = [subVC1, subVC2]
            
            pageViewController.apDelegate = self
        }
    }
}

extension CaseElastic3ViewController: ACPageViewControllerDelegate {
    func willUpdate(pageIndex: Int, viewController: ACPageViewController) {
        
    }
    
    func didUpdate(pageIndex: Int, viewController: ACPageViewController) {
        self.pageIdx = pageIndex
        
        let vc = viewController.orderedViewControllers[self.pageIdx] as! CaseElastic3SubVCType
        let tHeight = vc.tableView.contentSize.height
        guard let containerViewHeight = containerView.constraints.filter({$0.firstAttribute == .height}).first else { return }
        containerViewHeight.constant = tHeight
        
        print("height: \(vc.tableView.contentSize.height)")
    }
    
    func didUpdate(pageCount: Int, viewController: ACPageViewController) {
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
