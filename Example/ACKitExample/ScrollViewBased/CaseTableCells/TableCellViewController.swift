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
        tableView.registerCellNib(SampleTableViewCell1.self)
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
            let cell: SampleTableViewCell1 = tableView.dequeueReusableCell(for: indexPath)
            return cell
        } else {
            let cell: SampleTableViewCell2 = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}
