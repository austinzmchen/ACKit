//
//  TableCellViewController.swift
//  ACKit
//
//  Created by Austin Chen on 2017-08-24.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class TableCellViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "SampleTableViewCell1", bundle: nil), forCellReuseIdentifier: "kSampleTableViewCell1")
//        tableView.register(UINib(nibName: "SampleHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "kSampleHeaderView")
    }


}

extension TableCellViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "kSampleHeaderView") as! SampleHeaderView
//        headerView.label.text = "Top"
//        headerView.button.setTitle("bottom", for: .normal)
//        headerView.backgroundColor = UIColor.red
//        return headerView
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return tableView.dequeueReusableCell(withIdentifier: "kSampleTableViewCell1") as! SampleTableViewCell1
        } else {
            return tableView.dequeueReusableCell(withIdentifier: "kSampleTableViewCell2") as! SampleTableViewCell2
        }
    }
}
