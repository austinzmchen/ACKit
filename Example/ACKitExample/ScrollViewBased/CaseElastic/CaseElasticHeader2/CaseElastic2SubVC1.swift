//
//  CaseElastic2SubVC1.swift
//  MBNA
//
//  Created by Austin Chen on 2018-01-22.
//  Copyright © 2018 Austin Chen. All rights reserved.
//

import UIKit
import ACKit

protocol MBSnapshotHeaderViewDelegateType: class {
    var tableView: UITableView! { get }
    weak var delegate: MBSnapshotHeaderViewDelegate? { get set }
}

protocol MBSnapshotHeaderViewDelegate: class {
    func verticalScrollViewDidScroll(_ scrollView: UIScrollView, scrollDirection: ACScrollDirection)
    func verticalScrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    func verticalScrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    
    func verticalScrollViewDidPan(_ scrollView: UIScrollView, gestureRecognizer: UIPanGestureRecognizer)
}

class CaseElastic2SubVC1: UIViewController, CaseElastic3SubVCType, MBSnapshotHeaderViewDelegateType {
    @IBOutlet weak var tableView: UITableView!

    weak var delegate: MBSnapshotHeaderViewDelegate?
    
    lazy var tableDataDelegate: CE2ScrollViewDataDelegate = {
        let dd = CE2ScrollViewDataDelegate(viewController: self)
        tableView.delegate = dd
        return dd
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        _ = tableDataDelegate
        
        tableView.panGestureRecognizer.addTarget(self, action: #selector(pan(recognizer:)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        tableView.scrollRectToVisible(CGRect.init(x: 0, y: 0, width: 1, height: 1), animated: false)
//        tableView.isScrollEnabled = false
//        tableView.panGestureRecognizer.addTarget(self, action: #selector(pan(recognizer:)))
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        //        print("cs: \(tableView.contentSize)")
    }
    
    @objc func pan(recognizer: UIPanGestureRecognizer) {
        delegate?.verticalScrollViewDidPan(tableView, gestureRecognizer: recognizer)
    }
}

extension CaseElastic2SubVC1: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kcell")
        cell?.textLabel?.text = "Title One, row: \(indexPath.row)"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alertVC = UIAlertController(title: "Title", message: "tap works!", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
}

class CE2ScrollViewDataDelegate: ACTableViewDataDelegate {
    unowned var vc: MBSnapshotHeaderViewDelegateType
    
    init(viewController: MBSnapshotHeaderViewDelegateType) {
        self.vc = viewController
    }
}

extension CE2ScrollViewDataDelegate {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        
        vc.delegate?.verticalScrollViewDidScroll(scrollView, scrollDirection: scrollDirection)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        vc.delegate?.verticalScrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        vc.delegate?.verticalScrollViewDidEndDecelerating(scrollView)
    }
}
