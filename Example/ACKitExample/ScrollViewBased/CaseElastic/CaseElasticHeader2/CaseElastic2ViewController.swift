//
//  CaseElasticHeader2ViewControlle.swift
//  ACKit_Example
//
//  Created by Austin Chen on 2018-02-07.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import ACKit

class CaseElastic2ViewController: UIViewController {
    
    @IBOutlet weak var headerView: ElasticView!
    @IBOutlet weak var tabsHeaderView: ACTabsHeaderView!
    
    var isListeningToScroll = false
    var isListeningToPan = false
    var previousElasticHeight: CGFloat?
    var previvousOffsetY: CGFloat?
    
    var pageVC: ACPageViewController!
    
    lazy var scrollDelegate = {
        return CaseElastic2ScrollViewDelegate(vc: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.maxExpandableHeight = 300
        headerView.minExpandableHeight = 100
        
        // tabs header
        (tabsHeaderView.dataDelegate as? ACTabsHeaderCollectionViewDataDelegate)?.tabTitles = ["Tab 1", "Tab 2"]
        tabsHeaderView.cellWidth = UIScreen.main.bounds.width / 2.0
        tabsHeaderView.delegate = self
        tabsHeaderView.collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedVC" {
            pageVC = segue.destination as! ACPageViewController
            
            let subVC1 =  storyboard?.instantiateViewController(withIdentifier: "subVC1") as! CaseElastic2SubVC1
            let subVC2 =  storyboard?.instantiateViewController(withIdentifier: "subVC2") as! CaseElastic2SubVC2
            pageVC.orderedViewControllers = [subVC1, subVC2]
            
            pageVC.orderedViewControllers.forEach{
                ($0 as? MBSnapshotHeaderViewDelegateType)?.delegate = scrollDelegate
            }
            pageVC.apDelegate = self
        }
    }
}

extension CaseElastic2ViewController: ACTabsHeaderViewDelegate {
    func didSelectTab(_ tabsHeader: ACTabsHeaderView, atIndex idx: Int, animated: Bool) {
        pageVC.scrollToViewController(index: idx)
    }
}

extension CaseElastic2ViewController: ACPageViewControllerDelegate {
    
    func willUpdate(pageIndex: Int, viewController: ACPageViewController) {
        let vc = viewController.orderedViewControllers[pageIndex] as? MBSnapshotHeaderViewDelegateType
        vc?.tableView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    func didUpdate(pageIndex: Int, viewController: ACPageViewController) {
    }
    
    func didUpdate(pageCount: Int, viewController: ACPageViewController) {
    }
}

class CaseElastic2ScrollViewDelegate: ACTableViewDataDelegate {
    unowned let vc: CaseElastic2ViewController
    
    init(vc: UIViewController) {
        self.vc = vc as! CaseElastic2ViewController
    }
}

extension CaseElastic2ScrollViewDelegate: MBSnapshotHeaderViewDelegate {
    
    func verticalScrollViewDidScroll(_ scrollView: UIScrollView, scrollDirection: ACScrollDirection) {
        switch scrollDirection {
        case .none, .bounceUp, .bounceDown:
            // add elasticity
            if scrollView.contentOffset.y < 0,
                vc.headerView.cHeight >= vc.headerView.maxExpandableHeight
            {
                let y = abs(scrollView.contentOffset.y)
                vc.headerView.elasticZoomConstant = y
            }
            return // filter out
        default:
            break
        }
        
        guard !vc.isListeningToPan else {return}
        
        if vc.isListeningToScroll == false {
            vc.isListeningToScroll = true
            vc.previvousOffsetY = scrollView.contentOffset.y
            vc.previousElasticHeight = vc.headerView.constraints.front{$0.firstAttribute == .height}?.constant
        }
        
        if vc.isListeningToScroll {
            let offsetYDelta = scrollView.contentOffset.y - vc.previvousOffsetY!
            vc.headerView.cHeight = max(min(vc.previousElasticHeight! - offsetYDelta, vc.headerView.maxExpandableHeight),
                              vc.headerView.minExpandableHeight)
        }
    }
    
    func verticalScrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            vc.isListeningToScroll = false
        }
    }
    
    func verticalScrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        vc.isListeningToScroll = false
    }
    
    func verticalScrollViewDidPan(_ scrollView: UIScrollView, gestureRecognizer: UIPanGestureRecognizer) {
        let t = gestureRecognizer.translation(in: gestureRecognizer.view?.superview)
        switch gestureRecognizer.state {
        case .began:
            break
        case .changed:
            guard scrollView.contentOffset.y < 0,
                let v = Optional.some(gestureRecognizer.velocity(in: gestureRecognizer.view?.superview)),
                 v.y > 0 /* only care pan down */ else
            {
                if vc.isListeningToPan {
                    vc.isListeningToPan = false
                    vc.isListeningToScroll = false
                }
                return
            }
            
            if vc.isListeningToPan == false {
                vc.isListeningToPan = true
                vc.previousElasticHeight = vc.headerView.constraints.front{$0.firstAttribute == .height}?.constant
                
            }
            
            let p = CGPoint(x: t.x, y: t.y)
            vc.headerView.cHeight = max(min(vc.previousElasticHeight! + p.y, vc.headerView.maxExpandableHeight),
                              vc.headerView.minExpandableHeight)
            
        case .ended, .failed, .cancelled:
            vc.isListeningToPan = false
            vc.isListeningToScroll = false
            break
        default: break
        }
    }
}
