//
//  CaseElastic3ViewController.swift
//  MBNA
//
//  Created by Austin Chen on 2017-12-14.
//  Copyright © 2017 Austin Chen. All rights reserved.
//

import UIKit
import ACKit

class CaseTwitterLikeElasticHeader: UIViewController {
    
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var elasticView1: ElasticView!
    @IBOutlet weak var elasticView2: ElasticView!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var tableDataDelegate = TableDataDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainScrollView.delegate = self
        
        tableView.dataSource = tableDataDelegate
        tableView.delegate = tableDataDelegate
        
        elasticView1.contentView.backgroundColor = UIColor.green
        elasticView1.maxExpandableHeight = 300
        elasticView1.minExpandableHeight = 100
        
        elasticView2.contentView.backgroundColor = UIColor.yellow
        elasticView2.maxExpandableHeight = 100
        elasticView2.minExpandableHeight = 50
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.constraints.front{$0.firstAttribute == .height}?.constant = tableView.contentSize.height
    }
}

extension CaseTwitterLikeElasticHeader: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // add expanding
        let offsetY = scrollView.contentOffset.y
        elasticView1.cOffsetY = offsetY
        
        //
        elasticView2.cOffsetY = offsetY
        
        // add elasticity
        if scrollView.contentOffset.y < 0 {
            let y = abs(scrollView.contentOffset.y)
            
            elasticView2.elasticZoomConstant = y
        }
    }
}

private class TableDataDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kcell")
        cell?.textLabel?.text = "Title One, row: \(indexPath.row)"
        return cell!
    }
}
