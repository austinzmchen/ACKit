//
//  MBAccountRecentActivityViewController.swift
//  MBNA
//
//  Created by Austin Chen on 2018-01-22.
//  Copyright © 2018 Austin Chen. All rights reserved.
//

import UIKit
import ACKit

class CaseElastic3SubVC1: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.scrollRectToVisible(CGRect.init(x: 0, y: 0, width: 1, height: 1), animated: false)
//        tableView.isScrollEnabled = false
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        print("cs: \(tableView.contentSize)")
    }
}

extension CaseElastic3SubVC1: UITableViewDelegate, UITableViewDataSource {
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
