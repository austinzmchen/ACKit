//
//  CaseElastic2SubVC2.swift
//  MBNA
//
//  Created by Austin Chen on 2018-01-22.
//  Copyright © 2018 Austin Chen. All rights reserved.
//

import UIKit
import ACKit

class CaseElastic2SubVC2: UIViewController, CaseElastic3SubVCType, MBSnapshotHeaderViewDelegateType {
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
    
    @objc func pan(recognizer: UIPanGestureRecognizer) {
        delegate?.verticalScrollViewDidPan(tableView, gestureRecognizer: recognizer)
    }
}

extension CaseElastic2SubVC2: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kcell")
        cell?.textLabel?.text = "Title Two, row: \(indexPath.row)"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alertVC = UIAlertController(title: "Title", message: "tap works!", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}

