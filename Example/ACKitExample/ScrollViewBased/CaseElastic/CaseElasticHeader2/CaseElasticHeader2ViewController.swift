//
//  CaseElasticHeader2ViewControlle.swift
//  ACKit_Example
//
//  Created by Austin Chen on 2018-02-07.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import ACKit

class CaseElasticHeader2ViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var prevH: CGFloat?
    var prevY: CGFloat?
    
    lazy var scrollDelegate = {
        return CaseElastic2ScrollViewDelegate(vc: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = scrollDelegate
    }
}

extension CaseElasticHeader2ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kcell")
        cell?.textLabel?.text = "Title"
        return cell!
    }
}

class CaseElastic2ScrollViewDelegate: ACTableViewDataDelegate {
    unowned let vc: CaseElasticHeader2ViewController
    
    init(vc: UIViewController) {
        self.vc = vc as! CaseElasticHeader2ViewController
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        
        let offsetY = scrollView.contentOffset.y
        let h = vc.headerView.constraints.filter{$0.firstAttribute == .height}.first

        if vc.prevH == nil {
            vc.prevH = h?.constant
            vc.prevY = offsetY
        }
        
        switch scrollDirection {
        case .up:
            h?.constant = max(vc.prevH! - (offsetY - vc.prevY!), 50)
        case .down:
            h?.constant = min(vc.prevH! - (offsetY - vc.prevY!), 200)
        case .bounceDown:
//            print("bounceDown")
            let a = vc.prevH! - (offsetY - vc.prevY!) // min(vc.prevH! - (offsetY - vc.prevY!), 200)
            print(a)
            h?.constant = a
        default:
            break
        }

//        if offsetY == 0 {
////            print("do nothing")
//        } else if offsetY > 0 {
////        print(max(200 - offsetY, 50))
//            h?.constant = max(prevH! - offsetY, 50)
//        } else {
////            print(min(prevH! - offsetY, 200))
//            h?.constant = min(prevH! - offsetY, 200)
//        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            vc.prevH = nil
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        vc.prevH = nil
    }
}
